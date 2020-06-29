function val = vdist(p, q)
    if nargin < 3
        val = 0.5 * sum(abs(p-q));
    end
end