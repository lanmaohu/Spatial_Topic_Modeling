function [Pz0, Pzt, Pzu] = updatePzForTimeAndUser(Pz0, Pzt, Pzu, n_user, n_time, n_doc_ztu, n_doc_tu, optimFunc, options, penalty)

%% update Pz0, Pzu, Pzt.
func = @(x)negLogLikelihoodPz0ForTimeAndUserFunc(x, Pzt, Pzu, n_time, n_user, n_doc_ztu, n_doc_tu);
x0 = Pz0;
Pz0 = optimFunc(func,x0,penalty*ones(size(x0)),options); % efficiency should be fine

new_Pzt = zeros(size(Pzt));
for t = 1:n_time
    func = @(x)negLogLikelihoodPztByTimeForTimeAndUserFunc(x, t, Pz0, Pzt, Pzu, n_doc_ztu, n_doc_tu);
    x0 = Pzt(:,t);
    new_Pzt(:,t) = optimFunc(func,x0,penalty*ones(size(x0)),options);
end
Pzt = new_Pzt;

new_Pzu = zeros(size(Pzu));
for u = 1:n_user
    func = @(x)negLogLikelihoodPzuByUserForTimeAndUserFunc(x, u, Pz0, Pzt, Pzu, n_doc_ztu, n_doc_tu);
    x0 = Pzu(:,u);
    new_Pzu(:,u) = optimFunc(func,x0,penalty*ones(size(x0)),options);
end
Pzu = new_Pzu;
