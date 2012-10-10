var Foo;

Foo = (function() {

  function Foo(name) {
    this.name = name;
  }

  Foo.prototype.bar = function() {
    return console.log(this.name);
  };

  return Foo;

})();

exports.Foo = Foo;
