function m=wk1read1(filename, r, c, rng)
%WK1READ Read spreadsheet (WK1) file.
%   A = WK1READ('FILENAME') reads all the data from a Lotus WK1 spreadsheet 
%   file named FILENAME into array cells A. 
%
%   A = WK1READ('FILENAME',R,C) reads data from a Lotus WK1 spreadsheet
%   file starting at row R and column C, into the matrix M.  R and C
%   are zero-based so that R=C=0 is the first cell of the spreadsheet.
%
%   A = WK1READ('FILENAME',R,C,RNG)  specifies a cell range or named
%   range for selecting data from the spreadsheet.  A cell range is
%   specified by RNG = [R1 C1 R2 C2] where (R1,C1) is the upper-left
%   corner of the data to be read and (R2,C2) is the lower-right 
%   corner. RNG can also be specified using spreadsheet notation as 
%   in RNG = 'A1..B7' or a named range like 'Sales'.
%
%   See also WK1WRITE, CSVREAD, CSVWRITE.

%   Brian M. Bourgault 10/22/93
%   Copyright (c) 1984-98 by The MathWorks, Inc.
%
%   $Revision: 5.12 $  $Date: 1997/11/21 23:37:00 $
%
% include WK1 constants
%
wk1const;

%
% test for proper filename
%
if ~isstr(filename)
    error('First argument must be a string.');
end
%
% check/set row,col offsets
%
if nargin < 2
    r = 0;
end
if nargin < 3
    c = 0;
end
if nargin < 4
    % max range of cells for WK1 format
    rng = [1 1 8192 256];
end
%
% get the upper-left and bottom-right cells
% of the range to read into MATLAB
%
ulc = []; brc = [];
if ~isstr(rng)
    % user gave us a range, in matlab form, to import [1 1 3 5]
    ulc = rng(1:2);
    brc = rng(3:4);
else
    x = str2rng(rng);
    if ~isempty(x)
        % user gave us a cell range to import 'A1..C5'
        ulc = x(1:2)+1;
        brc = x(3:4)+1;
    else
        error('Invalid range string argument.');
    end
end

%
% Flip ulc and brc since we assume ulc = [C R] and brc = [C R] below.
%
if ~isempty(ulc),
  ulc = fliplr(ulc);
  brc = fliplr(brc);
end

%
% open the file Lotus uses Little Endian Format ONLY
%
if ~isempty(filename) & all(filename~='.'),
  filename = [filename '.wks'];
end
fid = fopen(filename,'rb', 'l');
if fid == (-1)
    error(['Could not open file ', filename ,'.']);
end

%
% Read Lotus WK1 BOF
%
header = fread(fid, 6,'uchar');
if(header(1) ~= LOTWKSBOFSTR)
    error('Not a valid WK1 file.');
end

%
% Start processing WKS Records
% Read WK1 record header
% cell = [col row]
% Note: Convert Lotus 0 based to 1 based cell coordinates 
%
rec = fread(fid, 2, 'ushort');
while(rec(1) ~= LOTEND(1)& rec(2) ~= LOTEND(2))
    if(rec(1) == LOTNUMBER(1))
        %
        % 8 byte double
        %
        fmt  = fread(fid, 1,'uchar');
        cell = fread(fid, 2,'ushort');
        cell = cell' + 1;
        val  = fread(fid, 1,'double');
        if((cell >= ulc) & (cell <= brc))
            m{cell(2)+r,cell(1)+c} = val(1);
        end
    else
        if(rec(1) == LOTINTEGER(1))
            %
            % 2 byte integer
            %
            fmt  = fread(fid, 1,'uchar');
            cell = fread(fid, 2,'ushort');
            val  = fread(fid, 1,'short');
            cell = cell' + 1;
            if((cell >= ulc) & (cell <= brc))
                m{cell(2)+r,cell(1)+c} = val(1);
            end
        else
            if(rec(1) == 15)
                %
                % Read string
                %
                fmt  = fread(fid, 1,'uchar');
                cell = fread(fid, 2,'ushort');
                cell = cell' + 1;
                val  = fread(fid, rec(2)-5,'uchar');
                for rr=1:(rec(2)-5)
                  if (val(rr)>223)&(val(rr)<240)
                    val(rr)=val(rr)+16;
                  end
                  if (val(rr)>127)&(val(rr)<176)
                     val(rr)=val(rr)+64;
                  end
                end
                stork=sprintf('%s',val(2:(rec(2)-5)));
                if((cell >= ulc) & (cell <= brc));
                    m{cell(2)+r,cell(1)+c} = stork;
                end
            else
               if(rec(1) == LOTFORMULA(1))
                   %
                   % 8 byte double from a Formula
                   %
                   fmt  = fread(fid, 1,'uchar');
                   cell = fread(fid, 2,'ushort');
                   cell = cell' + 1;
                   val  = fread(fid, 1,'double');
                   if((cell >= ulc) & (cell <= brc))
                      m{cell(2)+r,cell(1)+c} = val(1);
                   end
                   fread(fid, rec(2)-13,'uchar');
               else
                  if(rec(1) == LOTNRANGE(1) & isstr(rng))
                    %
                    % Named Range
                    %
                    if isstr(rng) 
                        n = fread(fid, 16,'char');
                       %n = upper(setstr(n'));
                        n = setstr(n');
                        n = deblank(n);
                        nrng = fread(fid, 4,'ushort');
                        nrng = nrng';
                        % need to pad n with zeros, this is a bug in strcmp
                       %rng = upper(setstr(rng));
                        rng = setstr(rng);
                        rng = deblank(rng);
                        if strcmp(rng,n)
                            % found the named range the user wants
                            ulc = nrng(1:2) + 1;
                            brc = nrng(3:4) + 1;
                            % bring ulc of named ranged to ulc of matrix
                            c = c - nrng(1);
                            r = r - nrng(2);
                        end
                     end                  
                  else
                    %
                    % read past this record
                    %
                    yui=fread(fid, rec(2),'uchar');
                    
                  end
               end
            end
        end
    end
    %
    % get the next WKS record header
    %
    rec = fread(fid, 2, 'ushort');
end

% close file
fclose(fid);

% Return only the valid part
m = m(2*r+1:end,2*c+1:end);
