%% PAGE RANK
clear; clc;

%% 1. Load data and build Google matrix
load('adjacency.mat','A');

n = size(A,1);
q = 0.15;

outdeg = sum(A,2);
G = zeros(n);

for j = 1:n
    if outdeg(j) == 0
        G(:,j) = 1/n;
    else
        G(:,j) = q/n + (1-q)*(A(j,:)'/outdeg(j));
    end
end

% Check stochasticity
colSums = sum(G,1);
fprintf('Max column sum error: %.3e\n', max(abs(colSums - 1)));

%% 2. Power iteration (INLINE, no function)

max_iter = 100;
%we start off with a uniform prob. distributuion, meaning that every page
%is equally important in the start, the sum=1
x = ones(n,1);
x = x / sum(x);

hist = zeros(n, max_iter);

for k = 1:max_iter

    %this part is really describing a movement of prob. through a network.
    %We can think of each page as being a node in a graph, xi is how likely
    %the surfer is to be on page i and Gij is how likely you go from page i
    %to j. To calculate how important of a page j is, we collect the
    %contribution fom all pages i that can send prob. to j.

    %we start at page i that has importance xi. It distributes its
    %importance such that the fraction q/n goes equally to all pages and
    %the fraction 1-q goes only to the pages it links to

    %if page i has many links -> each link gets a smaller share
    %if it has fewer links -> each link gets more

    %page j receives contribution from every page that links to it. So you
    %add that importance up
    x = G * x;

    %here me normalize, because after each iteration, floating point errors
    %accumulate
    x = x / sum(x);
    hist(:,k) = x;
end

p = x;

%[sorted_vals, idx] = sort(p, 'descend'); the most important pages in all
%the dataset

%% 3. Compare with eig (verification)

%here we are trying to compare the correctness of the power iteration
%method by comparing the computed PageRank vector with the dominant
%eigenvector of the G matrix using the eig function

%V -> matrix whose columns are the eigenvectors
%D -> a diagonal matrix of eigenvalus
[V,D] = eig(G);

%we are trying to find the dominant eigenvalue by turning the D diagonal
%matrix into a vector of eigenvalues. PageRank theory says that the largest
%eigenvalue is 1, but numerically MATLAB might return complex values  or
%tiny errors, so we are just taking the real part, not the complex one and
%picking the largest one we find there
[~, idx] = max(real(diag(D)));

%idx is the index of the eigenvector corresponding to eigenvalue 1, so this
%line gives us the eigenvector corresponding to eigenvalue 1
p_exact = V(:,idx);

%we now normalize 
p_exact = p_exact / sum(p_exact);

% align signs
%if v is an eigenvector, then -v will also be an eigenvector. They mean the
%same thing but MATLAB might return both of them. So we align them so
%comparison makes sense
if sign(p(1)) ~= sign(p_exact(1))
    p_exact = -p_exact;
end

%now we want to do the comaring between power iteration and the eig method,
%the results that both of the methods compute should be the same
disp('First 10 PageRank values (power iteration):')
disp(p(1:10))

disp('First 10 PageRank values (eig):')
disp(p_exact(1:10))

%the result is the same


%% 4. Top ranked pages

%a page is highly ranked in PageRank if it has: Many Incoming Links (not just)
%quantity, Incoming Links form Important Pages, and a Few Outgoing Links
%if a page is important it means that many links direct to it and thos
%elinks already come from strong pages (important pages)

%we are ordering the pages from most important to least important , and
%then storing the original page indices in ranked order in idx_sorted
[~, idx_sorted] = sort(p, 'descend');

disp('Top 10 pages (indices):')
disp(idx_sorted(1:10))


%% 5. STRUCTURAL ANALYSIS OF TOP PAGES
% This part explains WHY pages are highly ranked

%picking the top 5 pages to analyze
topK = 5;

fprintf('\n==============================\n');
fprintf('PAGE RANK STRUCTURE ANALYSIS\n');
fprintf('==============================\n\n');

%looping through those 5 pages we choose at the beginning
for k = 1:topK
    i = idx_sorted(k);

    %how many pages link to this page
    in_deg = sum(A(:,i));
    %how generous is this page in distributing its importance
    out_deg = sum(A(i,:));
    %which pages are giving importance to this page
    incoming_nodes = find(A(:,i));

    fprintf('Page %d\n', i);
    fprintf('----------------------\n');
    fprintf('PageRank value: %.6f\n', p(i));
    fprintf('In-degree: %d\n', in_deg);
    fprintf('Out-degree: %d\n', out_deg);

    fprintf('Incoming links from pages:\n');
    disp(incoming_nodes');

    fprintf('\nInterpretation:\n');

    % Explanation logic

    %is the in-degree above average, so we are comparing the page's
    %incoming lnks vs the average incoming links across all the pages
    %if this results to true then that means that this page is referenced
    %more than the normal pages making it popular, more important
    if in_deg > mean(sum(A))
        fprintf('\nHigh number of incoming links compared to average.\n');
    end

    %is the out-degree of this page below average, so we are comparing how
    %much this page links out vs the averga eoutging links, if the page
    %does have a low degree then that means that it has many incoming links
    %but few outgoing links, so even though it receives a lot of rank, it
    %does not pass much of it away -> it doesnt make other pages important
    if out_deg < mean(sum(A,2))
        fprintf('\nRelatively low out-degree, so rank is not diluted.\n');
    end

    fprintf('\nThis page is likely important because it is referenced by other pages.\n');
    fprintf('\nIf incoming pages also have high PageRank, this creates a reinforcement effect.\n\n');
end