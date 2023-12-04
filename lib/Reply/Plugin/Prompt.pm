package Reply::Plugin::Prompt;
use strict;
use warnings;
use Cwd qw(abs_path getcwd);
use File::Basename;
use Env   qw(HOME);
use POSIX qw(strftime);
use Term::ANSIColor;
use base 'Reply::Plugin';
use Exporter qw(import);
our @EXPORT =
  qw(section_wakatime section_result section_path section_os section_version section_time);

BEGIN {
    if ( $^O eq 'MSWin32' ) {
        require Win32::Console::ANSI;
        Win32::Console::ANSI->import;
    }
}

my @sections =
  ( 'wakatime', 'result', 'os', 'version', 'path', 'time' );    # section order
my %section_colors = (
    'wakatime' => '',
    'result'   => 'yellow on_red',
    'os'       => 'black on_yellow',
    'version'  => 'blue on_black',
    'path'     => 'white on_blue',
    'time'     => 'black on_white',
);
my $sep            = '';         # section separator
my $insert_text    = ' %s ';      # whitespaces which padded around section text
my $insert_result  = '✘ %s';
my $insert_version = ' %s';
my $insert_os      = '%s';
my $insert_time    = ' %s';
my $time_format    = '%H:%M:%S';  # time format
my $prompt_char    = '❯ ';        # prompt character
my $wakatime_cmd =
'wakatime-cli --write --plugin=repl-reply-wakatime --entity-type=app --entity=perl --alternate-language=perl --project=%s &';

sub new {
    my $class = shift;
    my $self  = $class->SUPER::new(@_);
    $self->{counter}  = 0;
    $self->{prompted} = 0;
    return $self;
}

sub section_wakatime {
    my $cmd = $wakatime_cmd;
    if ( $cmd =~ /%s/ ) {
        my $null    = $^O eq 'MSWin32' ? 'nul' : '/dev/null';
        my $old     = $?;
        my $project = `git rev-parse --show-toplevel 2> $null`;
        $? = $old;
        chomp $project;
        $project = abs_path getcwd if $project eq '';
        $project = basename $project;
        $cmd     = sprintf( $cmd, $project );
    }
    open my $fh, '-|', $cmd;
}

sub section_result {
    my $rst = '';
    if ( $? != 0 ) {
        $rst = color('yellow on_red') . " ✘ $? " . color('red on_yellow') . '';
    }
    return $rst;
}

sub section_path {
    my $path = abs_path getcwd;
    $path =~ s/^\Q$HOME\E/~/;
    my $icon;
    if ( $path eq '~' ) {
        $icon = '';
    }
    else {
        $icon = '';
    }
    $path = $icon . ' ' . $path;
    $path =~ s|([^/]+)$|color('bold') . $1|e;
    return $path;
}

sub section_os {
    my $os_icon = '';
    my $lsb_id;
    my %lsb_ids = (
        'Arch'   => '',
        'Gentoo' => '',
        'Ubuntu' => '',
        'Cent'   => '',
        'Debian' => '',
    );
    if ( $^O eq 'linux' ) {
        $os_icon = '';
        $lsb_id  = `lsb_release -i`;
        chomp $lsb_id;
        $lsb_id =~ s/.+:\s+//;
        if ( exists $lsb_ids{$lsb_id} ) {
            $os_icon = $lsb_ids{$lsb_id};
        }
        elsif ( exists $ENV{PREFIX}
            and $ENV{PREFIX} eq '/data/data/com.termux/files/usr' )
        {
            $os_icon = '';
        }
    }
    elsif ( $^O eq 'MSWin32' ) {
        $os_icon = '';
    }
    elsif ( $^O eq 'MacOS' ) {
        $os_icon = '';
    }
    return $os_icon;
}

sub section_version {
    my $version = $];
    $version =~ s/0+$//;
    return $version;
}

sub section_time {
    return strftime( shift, localtime );
}

# https://stackoverflow.com/questions/10342875/how-to-properly-use-the-try-catch-in-perl-that-error-pm-provides/10343025
eval {
    require File::XDG;
    my $xdg    = File::XDG->new( name => 'reply', api => 1 );
    my $config = $xdg->config_home->child('prompt.pl')->slurp_utf8;
    eval $config;
    1;
} or 1;

# these information will not change so source them once.
my $os      = section_os;
my $version = section_version;
$insert_version = sprintf( $insert_version, $version );
$insert_os      = sprintf( $insert_os,      $os );

sub prompt {
    my $self = shift;
    $self->{prompted} = 1;
    my $result       = $?;
    my @new_sections = ();

    if ( $? == 0 ) {
        foreach my $section (@sections) {
            if ( $section eq 'result' ) {
                next;
            }
            push @new_sections, $section;
        }
    }
    else {
        @new_sections = @sections;
    }

    my $ps1     = '';
    my $last_bg = '';
    foreach my $section (@new_sections) {
        my $text = '';
        if ( $section eq 'wakatime' ) {
            section_wakatime;
            next;
        }
        elsif ( $section eq 'result' ) {
            $text = sprintf( $insert_result, $result );
        }
        elsif ( $section eq 'path' ) {
            $text = section_path;
        }
        elsif ( $section eq 'time' ) {
            my $time = section_time $time_format;
            $text = sprintf( $insert_time, $time );
        }
        elsif ( $section eq 'os' ) {
            $text = $insert_os;
        }
        elsif ( $section eq 'version' ) {
            $text = $insert_version;
        }
        else {
            die "$section is not supported!";
        }
        my $color = $section_colors{$section};
        if ( $last_bg eq '' ) {
            $ps1 .= color($color) . sprintf( $insert_text, $text );
        }
        else {
            my ($bg) = $color =~ /(?<=on_)(\S+)/g;
            my ($fg) = $color =~ /(?<!on_)(\S+)/g;
            $ps1 .=
                color("$last_bg on_$bg")
              . $sep
              . color($fg)
              . sprintf( $insert_text, $text );
        }
        ($last_bg) = $color =~ /(?<=on_)(\S+)/g;
    }
    return
        color('reset')
      . $ps1
      . color("reset $last_bg")
      . $sep
      . color('reset') . "\n"
      . $self->{counter}
      . $prompt_char;
}

sub loop {
    my $self = shift;
    my ($continue) = @_;
    $self->{counter}++ if $self->{prompted};
    $self->{prompted} = 0;
    $continue;
}

1;

__END__

=head1 NAME

Reply::Plugin::Prompt - reply plugin for powerlevel10k style prompt

=head1 DESCRIPTION

L<Reply> plugin for L<powerlevel10k|https://github.com/romkatv/powerlevel10k>
style prompt. It is an enhancement of L<Reply::Plugin::FancyPrompt>.

Your perl deserves a beautiful REPL.

See L<README.md|https://github.com/wakatime/Reply-Plugin-Prompt> for screenshots.

Now this plugin supports L<wakatime|https://wakatime.com> which will record your
time to use perl in L<Reply>. If you don't want it, please remove I<wakatime>
from I<@sections>.

=head1 CONFIGURE

=head2 ENABLE

Enable this plugin in your F<~/.replyrc>:

    [Prompt]

=head2 CUSTOMIZE

Install L<nerd-font|https://github.com/ryanoasis/nerd-fonts> firstly.

Install L<File::XDG> > 1.00, then edit
F<${XDG_CONFIG_PATH:-$HOME/.config}/reply/prompt.pl>:

=encoding utf-8

    @sections =
      ( 'wakatime', 'result', 'os', 'version', 'path', 'time' );    # section order
    %section_colors = (
        'wakatime' => '',
        'result'   => 'yellow on_red',
        'os'       => 'black on_yellow',
        'version'  => 'blue on_black',
        'path'     => 'white on_blue',
        'time'     => 'black on_white',
    );
    $sep            = '';         # section separator
    $insert_text    = ' %s ';      # whitespaces which padded around section text
    $insert_result  = '✘ %s';
    $insert_version = ' %s';
    $insert_os      = '%s';
    $insert_time    = ' %s';
    $time_format    = '%H:%M:%S';  # time format
    $prompt_char    = '❯ ';        # prompt character
    $wakatime_cmd =
    'wakatime-cli --write --plugin=repl-reply-wakatime --entity-type=app --entity=perl --alternate-language=perl --project=%s &';
