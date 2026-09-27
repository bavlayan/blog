(function(){
  var root = document.documentElement;
  var btns = document.querySelectorAll('.phos button');
  function set(v){
    root.setAttribute('data-phos', v);
    btns.forEach(function(b){ b.setAttribute('aria-pressed', String(b.dataset.set === v)); });
    try { localStorage.setItem('phos', v); } catch(e){}
  }
  btns.forEach(function(b){ b.addEventListener('click', function(){ set(b.dataset.set); }); });
  try { var s = localStorage.getItem('phos'); if (s) set(s); } catch(e){}
})();
