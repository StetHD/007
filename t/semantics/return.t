use v6;
use Test;
use _007::Test;

{
    my $ast = q:to/./;
        (statements
          (sub (ident "f") (parameters) (statements
            (return (int 7))))
          (stexpr (call (ident "say") (call (ident "f")))))
        .

    is-result $ast, "7\n", "sub returning an Int";
}

{
    my $ast = q:to/./;
        (statements
          (sub (ident "f") (parameters) (statements
            (return (str "Bond. James Bond."))))
          (stexpr (call (ident "say") (call (ident "f")))))
        .

    is-result $ast, "Bond. James Bond.\n", "sub returning a Str";
}

{
    my $ast = q:to/./;
        (statements
          (sub (ident "f") (parameters) (statements
            (return (array (int 1) (int 2) (str "three")))))
          (stexpr (call (ident "say") (call (ident "f")))))
        .

    is-result $ast, "[1, 2, three]\n", "sub returning an Array";
}

{
    my $ast = q:to/./;
        (statements
          (sub (ident "f") (parameters) (statements
            (return (int 1953))
            (stexpr (call (ident "say") (str "Dead code. Should have returned by now.")))))
          (stexpr (call (ident "say") (call (ident "f")))))
        .

    is-result $ast, "1953\n", "a return statement forces immediate exit of the subroutine";
}

done;
