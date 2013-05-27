function [Pz0, Pzr, Pzu] = updatePzForRegionAndUser(Pz0, Pzr, Pzu, n_user, n_region, n_topic, n_doc_zru, n_doc_ru, optimFunc, options, penalty_alpha_z0, penalty_alpha_zr, penalty_alpha_zu, debug)

%% update Pz0, Pzu, Pzr.
if debug
    fprintf('before maximize Pzs: %f\n', logLikelihoodPzForRegionAndUserFunc(Pz0, Pzr, Pzu, n_user, n_region, n_doc_zru, n_doc_ru));
end

%     tic
%     fprintf('maximize Pz0\n');
func = @(x)negLogLikelihoodPz0ForRegionAndUserFunc(x, Pzr, Pzu, n_region, n_user, n_topic, n_doc_zru, n_doc_ru);
x0 = Pz0;
Pz0 = optimFunc(func,x0,penalty_alpha_z0*ones(size(x0)),options); % efficiency should be fine

%     fprintf('maximize Pzr\n');
new_Pzr = zeros(size(Pzr));
for r = 1:n_region
    func = @(x)negLogLikelihoodPzrByRegionForRegionAndUserFunc(x, r, Pz0, Pzr, Pzu, n_doc_zru, n_doc_ru);
    x0 = Pzr(:,r);
    new_Pzr(:,r) = optimFunc(func,x0,penalty_alpha_zr*ones(size(x0)),options);
end
Pzr = new_Pzr;
clear new_Pzr;

%     fprintf('maximize Pzu\n');
new_Pzu = zeros(size(Pzu));
for u = 1:n_user
    func = @(x)negLogLikelihoodPzuByUserForRegionAndUserFunc(x, u, Pz0, Pzr, Pzu, n_doc_zru, n_doc_ru);
    x0 = Pzu(:,u);
    new_Pzu(:,u) = optimFunc(func,x0,penalty_alpha_zu*ones(size(x0)),options);
end
Pzu = new_Pzu;
clear new_Pzu;

%     toc

if debug
    fprintf('after maximize Pzs: %f\n', logLikelihoodPzForRegionAndUserFunc(Pz0, Pzr, Pzu, n_user, n_region, n_doc_zru, n_doc_ru));
end