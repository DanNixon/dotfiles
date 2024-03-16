{inputs}: {
  additions = final: _prev: import ./pkgs {pkgs = final;};

  nur = final: prev: {
    nur = import inputs.nur {
      nurpkgs = prev;
      pkgs = prev;
    };
  };
}
