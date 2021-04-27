function caso=roleta(nr,pr)

u = rand(1);
pacum = 0;
for i=1:nr
    pacum = pacum+pr(i);
    if u <= pacum
        caso = i;
        return
    end
end
end
