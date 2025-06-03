document.addEventListener('click', e=>{
  const img=e.target.closest('#instagram img'); if(!img) return;
  const lb=document.createElement('div'); lb.className='lightbox'; lb.innerHTML='<img>';
  lb.querySelector('img').src=img.parentElement.href;
  lb.onclick=()=>lb.remove();
  document.body.append(lb);
});