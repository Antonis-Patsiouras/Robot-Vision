CSV = readmatrix('your-image');
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%PROJECT1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PROJECT1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
r = 0.067;
b = 0.125;

RT = zeros(2,size(CSV,1));
IT = zeros(3,(size(CSV,1)));
POS = zeros(3,(size(CSV,1)-1));
VRT = zeros(3,(size(CSV,1)));
VIT3 = zeros(3,(size(CSV,1)-1));
DF = zeros(2,(size(CSV,1)));
AVR = zeros(1,20);
AVL = zeros(1,20);
DFA = zeros(2,3);
F = zeros(3,20);
%% 

P2 = [1/r , 0 , b/r ; 1/r , 0 , -b/r]; %Π

%Ανάγνωση αρχείου CSV & εκχώριση μεταβλητών ταχυτήτων Fl & Fr για κάθε τροχό αντίστοιχα
for i = 1:size(CSV,1)
    CSV(i,2:3) = ((2*pi)*CSV(i,2:3)/60); %Mετατροπή ταχυτήτων σε rad/s
    Fr = CSV(i,3);
    Fl = CSV(i,2);
    x = r * ((Fr+Fl)/2); %Εύρεση ταχύτητας ρομπότ
    theta = r * ((Fr+Fl)/(2*b)); %Εύρεση γωνιακής ταχύτητας ροομπότ
    RT(:,i) = [x;theta]; %Διάνυσμα ταχυτήτων ρομπότ
end

%Εύρεση διανύσματος ταχυτήτων με βάση την εξίσωση "3" της εκφώνησης
for i = 1:size(RT,2)
    FF = P2 .* RT(:,i);
    for j = 1:size(FF,1)
        if j==1
            F(j,i) = sum(FF(j,:));
        elseif j==2
            F(j+1,i) = sum(FF(j,:));
        end
    end
end

%Εύρεση ταχυτήτων στο αδρανιακό 'Ι' σύστημα
for i = 1:size(F,2)
    R = [cos(RT(2,i)) , sin(RT(2,i)) , 0 ;
        -sin(RT(2,i)) , cos(RT(2,i)) , 0 ;
        0 , 0 , 1];
    RInv = inv(R);
    ITA = RInv .* F(:,i);
    for j = 1:size(F,1)
        IT(j,i) = sum(ITA(j,:));
    end
end

IT(2,:) = []; %Αφαίρεση 2ης γραμμής πίνακα που αντιστοιχεί στη συνιστώσα y που είναι μηδέν

%Εύρεση θέσεων ρομπότ κάθε χρονική στιγμή
for j = 1:size(IT,2)
    if j <= (size(IT,2)-1)
        if j==1
            POS(1,j) = IT(1,j) + (IT(1,j+1) - IT(1,j));
            POS(3,j) = 0 + (IT(2,j+1) - IT(2,j));
        else
            POS(1,j) = IT(1,j) + (IT(1,j+1) - IT(1,j));
            POS(3,j) = IT(2,j) + (IT(2,j+1) - IT(2,j));
        end
    else
        break
    end
end

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%POSITIONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%POSITIONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp(POS);
figure;
plot(POS);
%% 

VIT = diff(POS); %Παράγωγος θέσεων για εύρεση ταχυτήτων στο Ι σύστημα

% Προσθήκη και της 2ης συνιστώσας (γραμμής) 'y' για να γίνει ο πολ/μος με
% τον πίνακα στροφής που έχει διαστάσεις 3x3
for i = 1:size(VIT,2)
    for j = 1:size(VIT,1)
        if j == 3
            VIT3(j+1,i) = VIT(j,i);
        else
            VIT3(j,i) = VIT(j,i);
        end
    end
end

%Εύρεση ταχυτήτων στο R σύστημα
for i = 1:size(VIT,2)
    R = [cos(VIT(2,i)) , sin(VIT(2,i)) , 0 ;
        -sin(VIT(2,i)) , cos(VIT(2,i)) , 0 ;
        0 , 0 , 1];
    VRTA = R .* VIT3(:,i);
    for j = 1:size(VIT3,1)
        VRT(j,i) = sum(VRTA(j,:));
    end
end

VRT(3,:) = []; %Αφαίρεση γραμμής με μηδενικά

%Εύρεση διανύσματος ταχυτήτων με βάση την εξίσωση "3" της εκφώνησης
for i = 1:size(VRT,2)
    DFA = P2.*VRT(:,i);
    for j = 1:size(VRT,1)
        DF(j,i) = sum(DFA (j,:));
    end
end

%Εύρεση γωνιακών ταχυτήτων
for j = 1:size(DF,2)
    AVR(j) = (r .* DF(1,j))/2*b;
    AVL(j) = -(r .* DF(2,j))/2*b;
end

%Μετατροπή γωνιακών ταχυτήτων σε rpm
for j = 1:size(AVL,2)
    AVR(j) = (AVR(1,j)*60)/2*pi;
    AVL(j) = (AVL(1,j)*60)/2*pi;
end

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%VELOCITIES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VELOCITIES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp(DF);
disp(AVR);
disp(AVL);
