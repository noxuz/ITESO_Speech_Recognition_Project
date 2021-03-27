function sigma = sigmoideM(z)
    % Caso para matrices
    sigma = 1./(1+exp(-z(:)));
    sigma = reshape(sigma,size(z));
end