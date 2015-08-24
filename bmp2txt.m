[immag] = imread("Cursore.bmp");
fid = fopen("Cursore.txt", "w");

rr = 16;
cc = 16;
for r = 1:rr
  for c = 1:cc
    if (c == 1)
        fprintf(fid, "(");
    endif
    fprintf(fid, "'%d'", immag(r, c));
    if (c == cc)
        fprintf(fid, ")");
        if (r != rr)
            fprintf(fid, ",\n");
        endif
    else
        fprintf(fid, ",\    ");
    endif
  endfor
endfor
fclose(fid);
