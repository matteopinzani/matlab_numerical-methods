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


colSums = sum(G,1);
min(colSums)
max(colSums)

max(abs(sum(G,1) - 1))