load('adjacency.mat','A');

n = size(A,1); %the number of rows in A, namely the number of pages

q = 0.15; %setting the jump probability
%the prob. that the web surfer jumps randomly to any page instead
%of clicking on a link and goint to that specific page

outdeg = sum(A,2); %computation of outgoing links
%rows of A represent the outgoing links, so we are computing the outgoing 
%links for each page

G = zeros(n); %initialzing the G matrix, an n*n matrix full of zeroes

for j = 1:n %we have to loop through all the pages

    %if the page we are inspecting has no outgoing link, then the surfer is
    %guaranteed to randomly choose a page among all pages, because he cant
    %click on an outgoing link of the current page since it doesnt have one
    if outdeg(j) == 0

        %if the page doesnt have an outgoing link then the prob. of another
        %rnadom page to be visited by the sufer will be 1/n where n
        %represents the number of total pages
        G(:,j) = 1/n;

        %all rows of column j -> we are filling the entire column

    else

        %otherwise, if the page does have outgoing links
        G(:,j) = q/n + (1-q)*(A(j,:)'/outdeg(j));
        %create column j of the Google Matrix by giving every page a small
        %random-jump probability q/n and distributing the remaining prob.
        %equally among the pages that page j links to

    end

end

size(G)
G(1:5,1:5)