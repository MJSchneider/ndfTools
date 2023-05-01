function [data, metadata] = ndfRead(filePath)
%NDFREAD Read Neuroscience Data Format (NDF) file.
%   [DATA, METADATA] = NDFREAD(FILEPATH) reads the data and metadata
%   contained in the .ndf file specified by FILEPATH. This will contain the
%   raw signals from the recording session which still need to be
%   reconstructed. The documentation for this file type is contained in the
%   following links:
%   http://www.bndhep.net/Electronics/LWDAQ/Manual.html#Files
%   http://www.opensourceinstruments.com/Electronics/A3018/Neuroarchiver.html#Import-Export
%
%   See also NDFREADSESSION, NDFRECONSTRUCT, NDFWRITE, NDFEXTRACT

% Open file
fileID = fopen(filePath);

% Read header information
header_identifier = fread(fileID, 4, 'ubit8');
header_meta_data_address = fread(fileID, 1, 'ubit32', 'ieee-be');
header_data_address = fread(fileID, 1, 'ubit32', 'ieee-be');
header_meta_data_length = fread(fileID, 1, 'uint32', 'ieee-be');

% Check if the file is an NDF file
if header_identifier ~= [32;110;100;102]
    error_message = [ 'Identifier string '' ndf'' not present.\n' , ...
                      'Input is either corrupted or not an NDF file.' ];
    error('MJStools:ndfRoutines:invalideInputs', error_message)
end

% Print message
formatSpec = 'Importing %s...';
fprintf(formatSpec, filePath);

% Determine file length
fseek(fileID, 0, 'eof');
filesize = ftell(fileID);
readend = (filesize - header_data_address) / 4;

% Move to data address specified in the data header
fseek(fileID, header_data_address, 'bof');

% Read all data in one go
raw_data = fread(fileID, [4, readend], 'ubit8', 'ieee-be');

% Close file
fclose(fileID);

% Process raw data using vectorized operations
data.channel = raw_data(1, :);
data.value = bitshift(uint16(raw_data(2, :)), 8) + uint16(raw_data(3, :));
data.timestamp = raw_data(4, :);

% Print completion message
fprintf('Complete:');

end
