use v5.18;
sub read_line { chomp(my $s = <>); $s }
sub splited_read_line { split / /, read_line }

package UnionFind {
  sub new {
    my ($class, $n) = @_;
    bless [ 0 .. $n - 1], $class;
  }

  sub root {
    my ($self, $v) = @_;
    if ( $self->[$v] == $v ) {
      $v;
    }
    else {
      $self->[$v] = $self->root($self->[$v]);
    }
  }

  sub unite {
    my ($self, $v, $nv) = @_;
    $self->[$self->root($v)] = $self->root($nv);
  }

  sub same {
    my ($self, $v, $nv) = @_;
    $self->root($v) == $self->root($nv);
  }
}

my ($n, $q) = splited_read_line;
my $uf = UnionFind->new($n);
for my $i (0 .. $q - 1) {
  my ($t, $v, $nv) = splited_read_line;
  if ($t == 0) {
    $uf->unite($v, $nv);
  } else {
    say $uf->same($v, $nv) ? "Yes" : "No";
  }
}