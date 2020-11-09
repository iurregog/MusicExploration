function centers = substractive(data, ra)
[m,n]=size(data);
rb = 1.5*ra;

% Calculate the first center
for i = 1:m
    sum = 0;
    for j = 1:m
        %sum = sum + exp(-norm(data(i,:)-data(j,:))^2/(ra/2)^2); %euclid
        sum = sum + exp(-pdist2(data(i,:),data(j,:),'cityblock')^2/(ra/2)^2); %manhattan
    end
    D(i)= sum;
end
 [val, idx]=max(D);
 ma = val;
 centers = data(idx,:);
 cen = 1;
 
 % Calculate centers until all the data is within the influence 
 % range of a cluster center
 
 while(ma > rb)
     center = centers(cen,:);
     for i = 1:m
         sum = 0;
         for j = 1:m
             %sum = sum + exp(-norm(data(i,:)-center)^2/(rb/2)^2); %euclid
             sum = sum + exp(-pdist2(data(i,:),center,'cityblock')^2/(rb/2)^2); %manhattan
         end
         D(i) = D(i) - ma*sum;
     end
     [val, idx] = max(D);
     ma = val;
     centers = [centers; data(idx,:)];
     
     cen = cen + 1;
 end
end