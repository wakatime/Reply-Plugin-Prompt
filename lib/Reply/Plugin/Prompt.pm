package Reply::Plugin::Prompt;
use strict;
use warnings;
use Cwd   qw(abs_path getcwd);
use Env   qw(HOME);
use POSIX qw(strftime);
use Term::ANSIColor;
use base 'Reply::Plugin';

BEGIN {
    if ( $^O eq 'MSWin32' ) {
        require Win32::Console::ANSI;
        Win32::Console::ANSI->import;
    }
}

sub new {
    my $class = shift;
    my $self  = $class->SUPER::new(@_);
    $self->{counter}  = 0;
    $self->{prompted} = 0;
    return $self;
}

sub prompt {
    my $rst = '';
    if ( $? != 0 ) {
        $rst = color('yellow on_red') . " ✘ $? " . color('red on_yellow') . '';
    }
    my $self = shift;
    $self->{prompted} = 1;
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
    my $version = $];
    $version =~ s/0+$//;
    return
        color('reset')
      . $rst
      . color('on_yellow black')
      . " $os_icon "
      . color('yellow on_black') . ''
      . color('blue')
      . "  $version "
      . color('black on_blue') . ''
      . color('white')
      . " $path "
      . color('reset')
      . color('blue on_white') . ''
      . color('black') . '  '
      . strftime( '%H:%M:%S', localtime ) . ' '
      . color('reset white') . ''
      . color('reset') . "\n"
      . $self->{counter} . '❯ ';
}

sub loop {
    my $self = shift;
    my ($continue) = @_;
    $self->{counter}++ if $self->{prompted};
    $self->{prompted} = 0;
    $continue;
}

1;
