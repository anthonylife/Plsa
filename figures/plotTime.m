%PLOTTIME plot cost time of program excutation time  for different 
%  number of topics.

% Load the perplexity statistics
s_time = load('./excutation_time.txt');
figure;
set(gcf,'Position',[500 500 500 400]);
plot(s_time(:,1), s_time(:,2), 'b*--');

%axis([0 30 10 3000]);
title('Cost time for different topics');
xlabel('Number of topics');
ylabel('Cost time(s)');

saveas(gcf, ['./excutation_time', '.jpg']);

