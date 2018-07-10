function [] = PrepFuncs(PName)
%Prepration part of project
%  Checking the inputs and page and toolboxes and Timer !
clc; % Clear command window.

fprintf('Running %s ...\n',PName); % Message sent to command window.
clearvars; % Get rid of variables from prior run of this m-file.
tic; % Start timer.

imtool close all;  % Close all imtool figures.
format long g;
format compact;
captionFontSize = 14;

% Check that user has the Image Processing Toolbox installed.
hasIPT = license('test', 'image_toolbox');
if ~hasIPT
	% User does not have the toolbox installed.
	message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
	reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
	if strcmpi(reply, 'No')
		
		return;
	end
end



end

