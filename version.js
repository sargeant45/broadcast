window.onload = function(){
  function printTitle() {
    var responseObj = JSON.parse(this.responseText);
    document.getElementById("title").innerHTML = responseObj.name;
    document.getElementById("zip").setAttribute("href", responseObj.zipball_url);
    document.getElementById("tar").setAttribute("href", responseObj.tarball_url);
  }
  var request = new XMLHttpRequest();
  request.onload = printTitle;
  request.open('get', 'https://api.github.com/repos/sargeant45/broadcast/releases/latest', true)
  request.send()
}
