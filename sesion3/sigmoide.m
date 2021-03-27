function sigma = sigmoide(z)
    % Caso scalar
    sigma = 1/(1+exp(-z));
end