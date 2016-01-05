; docformat = 'rst'
;+
; :Author: Paulo Penteado (http://www.ppenteado.net), Jan/2016
;-
;+
; :Description:
;    Given an array iarr, returns the value(s) in the array that correspond to
;    the given quartile(s). If `cut` is set, instead of the quartile values, returns
;     a copy of the array, with minimum and maximum values given by the two quartiles provided.
;
; :Params:
;    iarr: in, required
;      The array for which the quartile(s) will be calculated.
;    quart: in, required
;      The desired quartile(s). It can be a scalar or an array.
;
; :Keywords:
;    dimension
;    cut: in,optional
;      If set, `quart` must be a two-element `array`. Instead of returning quartile
;      values, the function will return a copy of the array, with all values below the
;      low quartile (the first element in `quart`) will be set to the array's value
;      at that quartile, and all values above the high quartile (the second element
;      in `quart`) will be set to the value of the high quartile.
;    nan
;
; :Author: Paulo Penteado (http://www.ppenteado.net), Jan/2016
;-
function pp_quartile,iarr,quart,dimension=dimension,cut=cut,nan=nan
compile_opt idl2,logical_predicate
  nan=keyword_set(nan)
  if nan then begin
    w=where(finite(iarr))
    arr=iarr[w]
  endif else arr=iarr
  s=sort(arr)
  narr=n_elements(arr)
  q=arr[s[0>round(narr*quart)<(narr-1)]]
  if nan then arr=iarr
  return,keyword_set(cut) ? q[1]<arr>q[0] : q
end