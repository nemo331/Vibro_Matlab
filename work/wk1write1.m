function wk1write1(filename, m, r, c)
%WK1WRITE Write spreadsheet (WKS) file.
%   WK1WRITE('FILENAME',M) writes matrix M into a Lotus WKS spreadsheet
%   file with the name.  '.wk1' is appended to the filename if no
%   extension is given.
%
%   WK1WRITE('FILENAME',M,R,C) writes matrix M into a Lotus WKS spreadsheet
%   file, starting at offset row R, and column C in the file.  R and C
%   are zero-based so that R=C=0 is the first cell in the spreadsheet.
%
%   See also WK1READ, DLMREAD, DLMWRITE.

%   Brian M. Bourgault 10/22/93
%   Copyright (c) 1984-98 by The MathWorks, Inc.
%   $Revision: 5.10 $  $Date: 1997/11/21 23:37:02 $
%
% include WKS constants
%
wk1const

%
% test for proper filename
%
if ~isstr(filename),
    error('FILENAME must be a string.');
end;

if nargin < 2
    error('Requires at least 2 input arguments.');
end

%
% open the file Lotus uses Little Endian Format ONLY
%
if ~isempty(filename) & all(filename~='.'),
  filename = [filename '.wks'];
end
comp=computer;
if strcmp(comp(1:3),'MAC'),
  fid = fopen(filename,'wt', 'l');
else
  fid = fopen(filename,'wb', 'l');
end

if fid == (-1)
    error(['Could not open file ' filename '.']);
end
%
% check for row,col offsets
%
if nargin < 3
    r = 0;
end
if nargin < 4
    c = 0;
end

%
% Lotus WKS BOF
%
fwrite(fid, LOTWKSBOFSTR,'uchar');

%
% Lotus WKS dimensions size of matrix
[br,bc] = size(m);
LOTrng = [0 0 bc br];
wk1wrec(fid, LOTDIMENSIONS, 0);
fwrite(fid, LOTrng, 'ushort');

%
% Lotus WKS cpi
%
wk1wrec(fid, LOTCPI, 0);
fwrite(fid, [0 0 0 0 0 0], 'uchar');

%
% Lotus WKS calcount
%
wk1wrec(fid, LOTCALCCNT, 0);
fwrite(fid, 0, 'uchar');

% Lotus WKS calcmode
wk1wrec(fid, LOTCALCMOD, 0);
fwrite(fid, -1, 'char');

%
% Lotus WKS calorder
%
wk1wrec(fid, LOTCALCORD, 0);
fwrite(fid, 0, 'char');

%
% Lotus WKS split
%
wk1wrec(fid, LOTSPLTWM, 0);
fwrite(fid, 0, 'char');

%
% Lotus WKS sync
%
wk1wrec(fid, LOTSPLTWS, 0);
fwrite(fid, 0, 'char');

%
% Lotus WKS cursor12
%
wk1wrec(fid, LOTCURSORW12, 0);
fwrite(fid, 1, 'char');

%
% Lotus WKS window1, for now but needs work !!!
%
deffmt = 113;
wk1wrec(fid, LOTWINDOW1, 0);
fwrite(fid, [0 0], 'ushort');
fwrite(fid, deffmt, 'char');    
fwrite(fid, 0, 'char'); 
fwrite(fid, 10, 'ushort');
fwrite(fid, [bc br], 'ushort');
fwrite(fid, [0 0 0 0], 'ushort');
fwrite(fid, [0 0 0 0], 'ushort');
fwrite(fid, [72 0], 'ushort');

%
% Lotus WKS hidcol
%
x = 1:LOTHIDCOL(2);
buf = ones(size(x)) * 0;
wk1wrec(fid, LOTHIDCOL, 0);
fwrite(fid, buf, 'char');

%
% Lotus WKS margins
%
buf = [4 76 66 2 2];
wk1wrec(fid, LOTMARGINS, 0);
fwrite(fid, buf, 'ushort');

%
% Lotus WKS labelfmt
%
wk1wrec(fid, LOTLABELFMT, 0);
fwrite(fid, '''', 'char');

%
% start dumping the array, for now number format float
%
%celldisp (m(1,1))

for i = 1:br
   for j = 1:bc
      dd=cell2struct(m(i,j),'dat',2);
      sotrk=dd.dat;
      if (isempty(sotrk)~=1)
       %  isempty(sotrk)
        % wk1wrec(fid, [15 1+7 ], 1+7)
         %fwrite(fid, 241, 'char')
      %else
        if(ischar(sotrk)~=0)
           dlstr=length(sotrk);
           wk1wrec(fid, [15 dlstr+7 ], dlstr+7);
           fwrite(fid, 241, 'char');
        else
           wk1wrec(fid, LOTNUMBER, 0);
           fwrite(fid, deffmt, 'char');
        end
      %end
        
      fwrite(fid, [ c+j-1 r+i-1 ], 'ushort');
         
           if(ischar(sotrk)~=0)
              strform=sprintf('%d*uchar',dlstr);
              fwrite(fid, 39, 'uchar');
               for ggg=1:dlstr
                 if (sotrk(ggg)>191)&(sotrk(ggg)<240)
                   sotrk(ggg)=sotrk(ggg)-64;
                 end    
                
                 if (sotrk(ggg)>239)&(sotrk(ggg)<256)
                    sotrk(ggg)=sotrk(ggg)-16;
                 end
              end
              
           fwrite(fid, sotrk, strform);
           fwrite(fid, 0 , 'uchar');
           else
             fwrite(fid,sotrk , 'double');
           end
    %fwrite(fid, m{i,j}, 'double');
    %fwrite(fid, m{i,j}, 'uchar');
     end
   end
end


%
% Lotus WKS EOF
%
fwrite(fid, LOTEOFSTR,'uchar');

% close files
fclose(fid);
