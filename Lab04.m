%Ερώτημα 1
Tot=345;
[x,c] = ReadLiver(Tot);

%Ερώτημα 2
% μετρητης για υγιείς
y_counter=1;
%μετρητης για αρρώστους
a_counter=1; 

for i=1:Tot
    %υγιείς
    if c(i)==1  
        yg(:,y_counter)=x(:,i);  
        y_counter=y_counter+1;    
        
    %άρρωστοι    
    else
        ar(:,a_counter)=x(:,i); 
        a_counter=a_counter+1;
    end
end

[Rc1,Rep1,Weights1] = Perceptron(yg,ar,1,10000);
disp("Διάνυσμα των συντελεστών της γραμμικής συνάρτησης απόφασης")
disp(Weights1)

%Ερώτημα 3
error = 1-((Rc1(1)+ Rc1(2))/(Rep1(1)+Rep1(2)));
disp("Το σφάλμα είναι:")
disp(error)

%Ερώτημα 4
counter = 1;
number_of_repeats = 4;
all_reliabilities = zeros(1,40);
coefficient = zeros(1,40);
errors = zeros(number_of_repeats);

for a=0.5:0.5:20
    average_error = 0;
    
    for i=1:number_of_repeats
        [Rc,Rep,~] = Perceptron(yg,ar,a,10000);
        average_error = average_error + 1-((Rc(1)+Rc(2))/(Rep(1)+Rep(2)));
    end
    
    average_error = average_error/number_of_repeats;
    all_reliabilities(1,counter)= 1 - average_error;
    coefficient(counter) = a;
    counter=counter+1;
end
 
figure('Name','Αξιοπιστία του γραμμικού συστήματος ταξινόμησης συναρτήσει του συντελεστή εκπαίδευσης','NumberTitle','off')
plot(coefficient,all_reliabilities)
xlabel('Συντελεστής εκπαίδευσης')
ylabel('Αξιοπιστία')
xlim([coefficient(1) coefficient(counter-1)])
ylim([0 1])

repeats = zeros(1,11);
counter = 1;
average_errors = zeros(1,11);
for rep=10000:1000:20000
    average_error = 0;
    
    for i=1:number_of_repeats
        [Rc,Rep,~] = Perceptron(yg,ar,1,rep);
        average_error = average_error + 1-((Rc(1)+Rc(2))/(Rep(1)+Rep(2)));
    end
    
    average_error = average_error/number_of_repeats;
    average_errors(counter) = average_error;
    repeats(counter) = rep;
    counter=counter+1;
end

figure('Name','Αριθμός των επαναλήψεων του αλγόριθμου συναρτήσει του σφάλματος','NumberTitle','off')
plot(repeats,average_errors)
xlabel('Αριθμός των επαναλήψεων')
ylabel('Σφάλμα')
xlim([repeats(1) repeats(counter-1)])
ylim([0 inf])






