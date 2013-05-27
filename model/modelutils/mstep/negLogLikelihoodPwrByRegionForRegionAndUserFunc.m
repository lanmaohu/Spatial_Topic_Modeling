function [f, df] = negLogLikelihoodPwrByRegionFunc(x, rr, Pw0, Pwr, Pwz, tweet_word, n_doc, n_topic,doc_region, doc_topic)

% This function returns the function value, partial derivatives
% of the (general dimension) log likelihood function with respect to Pw0.
%
% Author:	Bo Hu 2013-01-16
%
% Inputs -----------------------------------------------------------------
% D is the dimension of x.
%
% Outputs ----------------------------------------------------------------
% f is function value, and df is partial derivative value.

% function value
Pwr(:,rr) = x; % Pwr = reshape(x, n_word, n_region);
f = 0;
% derivative value
df = zeros(size(x));

% precomputation
n_z_r = zeros(n_topic,1);
for z = 1:n_topic % O(z*r*v)
    n_z_r(z) = n_z_r(z) + sumPw(Pw0, Pwr, Pwz, z, rr);
end   


array = find(doc_region==rr);
for i = 1:length(array)% O(d)
    d= array(i);
        z = doc_topic(d);
        
        word_index_array = find(tweet_word(d,:));
        
        wordLength = length(word_index_array);
        freqVec = full(tweet_word(d, word_index_array));
        tmp = Pw0(word_index_array) + Pwz(word_index_array,z) + Pwr(word_index_array,rr);
        % f
        f = f + freqVec * (tmp- repmat(log(n_z_r(z)), wordLength, 1)) ;
        % df
        df(word_index_array) = df(word_index_array) + freqVec' - freqVec' .* exp(tmp)/ n_z_r(z);

end


% for d = 1:n_doc % O(d)
%     r = doc_region(d);
%     if rr == r
%         z = doc_topic(d);
%         
%         word_index_array = find(tweet_word(d,:));
%         
%         wordLength = length(word_index_array);
%         freqVec = full(tweet_word(d, word_index_array));
%         tmp = Pw0(word_index_array) + Pwz(word_index_array,z) + Pwr(word_index_array,r);
%         % f
%         f = f + freqVec * (tmp- repmat(log(n_z_r(z)), wordLength, 1)) ;
%         % df
%         df(word_index_array) = df(word_index_array) + freqVec' - freqVec' .* exp(tmp)/ n_z_r(z);
%         
%         
% %         word_index_array = find(tweet_word(d,:));
% %         for index = 1:length(word_index_array)
% %             w = word_index_array(index);
% %             freq = tweet_word(d,w);
% %             % f
% %             f = f + freq * (Pw0(w) + Pwz(w,z) + Pwr(w,r) - log(n_z_r(z)));
% %             %df
% %             df(w) = df(w) + freq;
% %             df(w) = df(w) - freq*exp(Pw0(w) +  Pwz(w, z) + Pwr(w,r))/ n_z_r(z);
% %         end
%     end
% end

f = -f;
df = -df;

% df = reshape(df, n_word* n_region, 1);


