%PLOTPERPLEX plot perplexity for different number of topics

% Load the perplexity statistics
perplexity = load('./perplexity.txt');
figure;
set(gcf,'Position',[500 500 500 400]);
plot(perplexity(:,1), perplexity(:,2), 'r*-.');

%axis([0 30 10 3000]);
title('Corpus perplexity in different topics');
xlabel('Number of topics');
ylabel('Perplexity');

saveas(gcf, ['./perpelxity', '.jpg']);
