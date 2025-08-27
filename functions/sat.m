function y = sat(x,value)

y = sign(x)*max(abs(x),value);

end