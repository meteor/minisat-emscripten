var process = {
  argv: ['node', 'minisat'],
  on: function () {},
  stdout: {
    write: function (str) {
      console.log("MINISAT-out:", str);
    }
  },
  stderr: {
    write: function (str) {
      console.log("MINISAT-err:", str);
    }
  }
};
