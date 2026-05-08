load('adjacency.mat','A');
T = readtable('labels.csv','TextType','string');
size(A)
height(T)
T(1:10,:)

%disp(A)

find(A(1,:))
%the page with index 1 is called Albedo
%here we are trying to find all the pages that Albedo links to 
%so albedo has some links, those links take us to other pages
%we want to find what those pages are, what we know is that since albedo
%has index 1 and therefore i=1, we have to find all js such that A(i,j)=1


T(find(A(1,:)),:) 
%this shows also the names of those pages that 
%Albedo has a link to
