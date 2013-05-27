function [Pw0, Pwz] = updatePw(Pw0, Pwz, n_topic, n_word, n_word_zw, n_word_z, optimFunc, options, penalty_beta_w0, penalty_beta_wz, debug)

%% update Pw0, Pwz
if debug
    fprintf('before maximize Pws: %f\n', logLikelihoodPwFunc(Pw0, Pwz, n_topic, n_word_zw, n_word_z));
end

%     tic
%     fprintf('maximize Pw0\n');
func = @(x)negLogLikelihoodPw0Func(x, Pwz, n_word, n_topic, n_word_zw, n_word_z);
x0 = Pw0;
Pw0 = optimFunc(func,x0,penalty_beta_w0*ones(size(x0)),options);
%     toc

%     tic
%     fprintf('maximize Pwz\n');
new_Pwz = zeros(size(Pwz));
for zz = 1:n_topic
    %         tic
    func = @(x)negLogLikelihoodPwzByTopicFunc(x, zz, Pw0, Pwz, n_word_zw, n_word_z);
    x0 = Pwz(:,zz);
    new_Pwz(:,zz) = optimFunc(func,x0,penalty_beta_wz*ones(size(x0)),options);
    %         toc
end
Pwz = new_Pwz;
clear new_Pwz;
%     toc

if debug
    fprintf('after maximize Pws: %f\n', logLikelihoodPwFunc(Pw0, Pwz, n_topic, n_word_zw, n_word_z));
end