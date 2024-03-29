function y = ffGn(N, Hinput, sigma, mu)
% FFGN  Fast (exact) fractional Gaussian noise and Brownian motion generator.
%
% Y = FFGN(N, H, SIGMA, MU) returns a vector containing a sequence of fractional Gaussian
% noise or fractional Brownian motion.  The generation process uses an FFT which makes it
% very fast.  The input arguments are:
%
%               N                       is the length of the output sequence.
%               H                       is the "Hurst" index of the resultant noise (0 < H <= 2).  For 0 < H <= 1,
%                                         the output will be fractional Gaussian noise with Hurst index H.  For
%                                         1 < H <= 2, the output will be fractional Brownian motion with Hurst
%                                         index H-1.  Either way, the power spectral density of the output will
%                                         be nominally proportional to 1/f^(2H-1).
%               sigma           is the standard deviation of the noise. [default = 1]
%               mu                      is the mean of the noise. [default = 0]
%
%       FFGN(N, H) returns a sequence of fractional Gaussian noise with a mean of zero
%       and a standard deviation of one or fractional Brownian motion derived from such
%       fractional Gaussian noise.
%
%       References: Davies & Harte (1987); Beran (1994); Bardet et al., 2002
%       This method is based on an embedding of the covariance matrix in a circulant matrix.
%
%   See also FGN, FFGNA, FGNDP.
%   Copyright � 2003-2005 by B. Scott Jackson
%   Revision: 1.2    Date: March 14, 2005
%   History:
%       Rev. 1.2 - 3/14/05 - Added some additional documentation and input argument checking.
%       Rev. 1.1 - 9/15/04 - Added the persistent variables and associated "if"-statement.
%                          - Changed "fftw" & "ifftw" functions to "fft" and "ifft".
%       Rev. 1.0 - 2/11/03 - Original version.

% Check input arguments
if ( (nargin < 2) | (nargin > 4) )
  error('Requires two to four input arguments.')
end
if (prod(size(N)) ~= 1) | (prod(size(Hinput)) ~= 1) | ~isnumeric(N) | ~isnumeric(Hinput) ...
    | ~isreal(N) | ~isreal(Hinput) | ~isfinite(N) | ~isfinite(Hinput)
  error('All input arguments must be finite real scalars.')
end
if (N <= 0)
  error('Length of the return vector must be positive.')
end
if (Hinput <= 0) | (Hinput > 2)
  error('The Hurst parameter must be in the interval (0,2].')
end
if (nargin > 2)
  if (prod(size(sigma)) ~= 1) | ~isnumeric(sigma) | ~isreal(sigma) | ~isfinite(sigma)
    error('All input arguments must be finite real scalars.')
  end
  if (sigma <= 0)
    error('Standard deviation must be greater than zero.')
  end
end
if (nargin > 3)
  if (prod(size(mu)) ~= 1) | ~isnumeric(mu) | ~isreal(mu) | ~isfinite(mu)
    error('All input arguments must be finite real scalars.')
  end
end
% Determine whether fGn or fBn should be produced.
if ( Hinput <= 1 )
  H = Hinput;
  fBn = 0;
else
  H = Hinput - 1;
  fBn = 1;

end
% Calculate the fGn.
if (H == 0.5)
  y = randn(1, N);  % If H=0.5, then fGn is equivalent to white Gaussian noise.
else
  % If this function was already in memory before being called this time,
  % AND the values for N and H are the same as the last time it was
  % called, then the following (persistent) variables do not need to be
  % recalculated.  This was done to improve the speed of this function,
  % especially when many samples of a single fGn (or fBn) process are
  % needed by the calling function.
  persistent Zmag Nfft Nlast Hlast
  %    if isempty(Zmag) | isempty(Nfft) | isempty(Nlast) |isempty(Hlast) | N ~= Nlast %| H ~= Hlast
  % The persistent variables must be (re-)calculated.
  Nfft = 2^ceil(log2(2*(N-1)));
  NfftHalf = round(Nfft/2);
  k = [0:NfftHalf, (NfftHalf-1):-1:1];
  Zmag = 0.5 .* ( (k+1).^(2.*H) - 2.*k.^(2.*H) + (abs(k-1)).^(2.*H) );
  clear k
  Zmag = real(fft(Zmag));
  if ( any(Zmag < 0) )
    error('The fast Fourier transform of the circulant covariance had negative values.');
  end
  Zmag = sqrt(Zmag);
  % Store N and H values in persistent variables for use during subsequent calls to this function.
  Nlast = N;
  Hlast = H;
  %   end
  Z = Zmag.*(randn(1,Nfft) + i.*randn(1,Nfft));
  y = real(ifft(Z)) .* sqrt(Nfft);
  clear Z
  y((N+1):end) = [];
end
% Convert the fGn to fBn, if necessary.
if (fBn)
  y = cumsum(y);
end
% Change the standard deviation.
if (nargin > 2)
  y = y * sigma;
end
% Change the mean.
if (nargin > 3)
  y = y + mu;
end