%AM: 03123156
%ΓΑΛΑΝΗΣ ΕΥΑΓΓΕΛΟΣ

%             1.1

 %αρχικοποιηση μεταβλητων (α)
 c1=0.4;
 c2=0.8;
 a=[1 0  0 0];
 b1=[c1 0 0 1-c1];
 b2=[c2 0 0 1-c2];

 
 %αποκριση πλατους και φασης (β)
 [h,w]=freqz(b1,a);
 plot(w,abs(h),w,angle(h));
 grid on;
 title("echo effect with c=0.4");
 legend("amplitude",'phase');
 ylabel("H[w]");
 xlabel("w");
 pause();

 [h,w]=freqz(b2,a);
 plot(w,abs(h),w,angle(h));
 grid on;
 title("echo effect with c=0.8");
 legend("amplitude",'phase');
 ylabel("H[w]")
 xlabel("w");
 pause();

 %διαγραμματα, πολοι και μηδενικα (γ)
 [z,p]=tf2zp(b1,a);
 zplane(z,p);
 title("zeros/poles echo effect with c=0.4");
 pause();
 [z,p]=tf2zp(b2,a);
 zplane(z,p);
 title("zeros/poles echo effect with c=0.8");
 pause();

 %διαγραμμα,κρουστικη αποκριση (δ)
 impz(b1,a,linspace(-2,5));
 title("Impulse Response ,echo (c=0.4)");
 pause();
 impz(b2,a,linspace(-2,5));
 title("Impulse Response ,echo (c=0.8)");
 pause();
 
 %αρχικοποίηση φίλτρο αντήχησης βαθμου 3 (ε)
 b3=conv(b2,b2);
 b3=conv(b2,b3);
 a3=[1,zeros(1,length(b3)-1)];

 %βηματα β->δ για το φιλτρο αντηχησης (ε)
 [h,w]= freqz(b3,a3);
 plot(w,abs(h),w,angle(h));
 grid on;
 title("reverb (βαθμός 3)");
 legend("amplitude",'phase');
 ylabel("H[w]");
 xlabel("w");
 pause();
 [z,p,k] = tf2zp(b3,a3);
 zplane(z,p);
 title("zeros/poles of reverb");
 pause();
 impz(b3,a3,linspace(-1,10));
 title("Impulse Response ,reverb");
 pause();

 %φίλτρο απαλοιφής της αντηχησης (devreverbaration) (στ)
 [b4,a4]=zp2tf(p,z,1/k); %φιλτρο απαλοιφης
 x = [1,1,1,1,1,zeros(1,length(a4)-4)]; %αρχικο σημα χ[n]
 n=0:length(x)-1;

 k2=filter(b2,a,x); %εφαρμογη echo
 k3=filter(b3,a3,x); %εφαρμογη reverb
 k4=filter(b4,a4,k3); %απαλοιφη reverb (devreverbaration)

 %γρ. παραστάσεις
 stem(n,x,'r','filled');%αρχικο σημα (α)
 legend("original signal");
 hold on;
 pause();
 stem(n,k2,'m','DisplayName','echoed signal'); %echo (β)
 hold on;
 pause();
 stem(n,k3,'b','DisplayName','reverbed signal'); %reverb (γ)
 hold on;
 pause();
 stem(n,k4,'g','DisplayName','de-reverbed signal'); %de-reverb(ανακτόμενο) (δ)
 pause();                                    %και κοινο συνολικο γραφημα.
 close all;

%              1.2

%(α)
z=[-0.8 0.8]';
p=[0.5-0.8i 0.5+0.8i]';

zplane(z,p);
title("zeros/poles 1.2(α)");
pause();
[b,a]=zp2tf(z,p,1);

%(β)
[h,w]=freqz(b,a);
plot(w,abs(h),w,angle(h));
grid on;
title("αποκριση συχνότητας 1.2(β)");
legend("amplitude",'phase');
ylabel("H[w]");
xlabel("w");
pause();

%(γ)
impz(b,a);
title("κρουστικη απόκριση 1.2(γ)");
pause();
stepz(b,a);
title("βηματική απόκριση 1.2(γ)");
pause();

%(δ)
p1=[0.527+0.844i,0.527-0.844i]';
p2=[0.53+0.848i,0.53-0.848i]';
p3=[0.55-0.88i,0.55+0.88i]';

[b,a]=zp2tf(z,p1,1);
impz(b,a);
title("κρουστικη απόκριση(δ), πόλους:0.527±0.844i");
pause();
zplane(z,p1);
pause();
[h,w]=freqz(b,a);
plot(w,abs(h));
grid on;
title("amplitude frequency response of poles:0.527±0.844i");
legend("amplitude");
ylabel("H[w]");
xlabel("w");
pause();

[b,a]=zp2tf(z,p2,1);
impz(b,a);
title("κρουστική απόκριση(δ), πόλους:0.53±0.848i");
pause();
zplane(z,p2);
pause();

[b,a]=zp2tf(z,p3,1);
impz(b,a);
title("κρουστική απόκριση(δ),πόλους 0.55±0.88");
pause();
zplane(z,p3);
pause();

%(ε) επαναληψη α->β για αλλους πολους
p4=[0.8+0.5i,0.8-0.5i]';

zplane(z,p4);
title("zeros/poles 1.2(ε)");
pause();
[b,a]=zp2tf(z,p4,1);
[h,w]=freqz(b,a);
plot(w,abs(h),w,angle(h));
grid on;
title("Απόκριση συχνότητας με πόλους 0.8 ± 0.5i");
legend("amplitude",'phase');
ylabel("H[w]");
xlabel("w");
pause();
close all;


%           2.1
% (α)
[y,fs]=audioread("flute_sequence.wav");
x=(0:length(y)-1)/fs;

plot(x,y);
title("flute sequence wave form (time)");
ylabel("amplitude");
xlabel("scaled time");
sound(y,fs);
pause();

%(β) σχεδίαση ενέργειας
y2=(y-min(y)) / (max(y)-min(y));
y2=2*y2-1;                      %κανονικοποιηση

plot(x,y2);
legend("flute sequence normalised wave form");
ylabel("amplitude");
xlabel("scaled time");
hold on;
pause();
n = 0:399;
w = 0.54 - 0.46 * cos(2 * pi * n /(400));

y_squared = y2 .^ 2; 
E = conv(y_squared, w,'same');
E=(E-min(E)) / (max(E)-min(E)); %κανονικποιηση

plot(x,E,'DisplayName','Energy','LineWidth',5);
pause();

%(γ) φασμα flute
y3=fft(y,4*16000);
w=linspace(0,16000,length(y3));
plot(w,abs(y3));
title("φάσμα flute sequence (frequency)");
ylabel("amplitude");
xlabel("scaled frequency");
pause();
close all;

%(δ) απομόνωση 1ης νότας
y4=y(1:length(y)/4);
x=linspace(0,3/4,12000);
plot(x,y4);
title("first note wave form (time)");
ylabel("amplitude");
xlabel("scaled time");
pause();
%(ε) φάσμα 1ης νοτας
w4=fft(y4,16000);
plot(abs(w4));
title("φάσμα first note (frequency)");
ylabel("amplitude");
xlabel("scaled frequency");
pause();

%(στ) φιλτρα απομονωση και αρμονικες
[y,fs]=audioread("string_note.wav");
wt=linspace(0,length(y)/16000,fs);
plot(linspace(0,length(y)/16000,4*fs),y);
title("string note wave form (time)");
ylabel("amplitude");
xlabel("scaled time");
pause();

y=fft(y,16000);
wf=linspace(0,length(y),fs);
plot(abs(y)); 
title("amplitude frequency response string note (frequency)");
ylabel("amplitude");
xlabel("scaled frequency");
pause();

%3rd harmonic w=1979 f=1979/2π Hz
f=((abs(wf)<=1979+1) & (abs(wf)>=1979-1)); 

%to φιλτρο το εκανα πριν κανονικοποιησω 
% μερικες τιμες οποτε τα 1979 και 3298 ειναι απο πριν τη κανονικοποιηση και
% πιστεψα οτι ηταν καλυτερο να τα αφησω

yf=y.*(f');                            %mult me filtro harm 3
plot(linspace(0,length(y)/4,16000),abs(yf));
title("amplitude frequency response filtered string note (3rd harmonic)");
ylabel("amplitude");
xlabel("scaled frequency");
pause();
yr=ifft(yf,16000);
plot(wt,real(yr));
title("string filtered note 3rd harmonic wave form (time)");
ylabel("amplitude");
xlabel("scaled time");
pause();

%5th harmonic w=3298 f=3298/2π Hz
f=1*((abs(wf)<=3298+1) & (abs(wf)>=3298-1));
yf=y.*(f');                           %mult me filtro harm 5
plot(linspace(0,length(y)/4,16000),abs(yf));
title("amplitude frequency response filtered string note (5th harmonic)");
ylabel("amplitude");
xlabel("scaled frequency");
pause();
yt=ifft(yf,16000);
plot(wt,real(yt));
title("string filtered note 5th harmonic wave form (time)");
ylabel("amplitude");
xlabel("scaled time");
pause();
close all;

%        2.2
%(α) piano note
[y,fs]=audioread("piano_note.wav");
x=linspace(0,length(y)/44100,50000);
plot(x,y);
title("multiple piano note wave forms (time)")
legend("original piano note ");
ylabel("amplitude");
xlabel("scaled time");
hold on;
sound(y,fs);
pause();

%(β) filters
c=0.85;
p=850;

ae=[1, [zeros(1,p)]];
be=[c ,[zeros(1,p-1)], 1-c];    %echo filter

br=be;
for i=1:11
    br=conv(br,be);              %reverb filter
end
ar=[1,[zeros(1,length(br)-1)]];

out1=filter(be,ae,y);%echo
out2=filter(br,ar,y);%reverb


plot(x,out1,'DisplayName','echoed piano note');
sound(out1,fs);
hold on;
pause();

plot(x,out2,'DisplayName','reverbed piano note (12th degree)');
sound(out2,fs);
pause();

%(γ) fft, φασμα σε Db
h1=fft(y,16000); %og
h2=fft(out1,16000); %echo
h3=fft(out2,16000); %reverb

plot(mag2db(abs(h1)));
title("multiple piano notes frequency spectrum")
legend("original piano note");
ylabel("amplitude");
xlabel("scaled frequency");
hold on;
pause()
plot(mag2db(abs(h2)),'DisplayName','echoed piano note');
hold on;
pause();
plot(mag2db(abs(h3)),'DisplayName','reverbed piano note (12th degree)');
pause();
close all;

%(δ) καταγραφη echo και reverb σε .wav file
audiowrite('echoed.wav',out1,fs);
audiowrite('reverbed.wav',out2,fs);

%(ε)φίλτρο απαλοιφής ,dereverb
y2=filter(ar,br,out2); 
                       %η προηγουμενη μεθοδος y->tf2zp->zp2tf->y, δε δουλευε,
                       % φανταζομαι μεγαλο time complexity για p=800 πολυώνυμο
plot(y2);%teliko dereverbed
title("de-reverb filter effect on piano note wave forms (time)")
legend('final filtered piano note (de-reverbed)');
ylabel("amplitude");
xlabel("scaled time");
hold on;
pause();
plot(out2,'DisplayName','original piano note (reverbed)'); %reverbed shma
pause();
close all;

%(στ) Telos
b5=[c ,[zeros(1,p+5-1)], 1-c];
b10=[c ,[zeros(1,p+10-1)], 1-c];
b50=[c ,[zeros(1,p+50-1)], 1-c]; 
b=b5;
for i=1:11
    b5=conv(b,b5);              %reverb filter
end
a5=[1,[zeros(1,length(b5)-1)]];
b=b10;
for i=1:11
    b10=conv(b,b10);              %reverb filter
end
a10=[1,[zeros(1,length(b10)-1)]];
b=b50;
for i=1:11
    b50=conv(b,b50);              %reverb filter
end
a50=[1,[zeros(1,length(b50)-1)]];

% τελευταια υποερωτηματα, απλα επαναλαμβανονται με διαφορετικα νουμερα
%(ar,br,a5,b5,a10,b10,a50,b50)
out5=out2;
y5=filter(a5,b5,out5); 
plot(y5);%teliko dereverbed
hold on;
title("de-reverb filter effect on piano note wave forms (time), Delay: +5")
legend('final filtered piano note (de-reverbed)');
ylabel("amplitude");
xlabel("scaled time");
pause();
plot(out5,'DisplayName','original piano note (reverbed)');%reverbed shma
pause();
close all;

out10=out2;
y10=filter(a10,b10,out10); 
plot(y10);%teliko dereverbed
title("de-reverb filter effect on piano note wave forms (time), Delay: +10")
legend('final filtered piano note (de-reverbed)');
ylabel("amplitude");
xlabel("scaled time");
hold on;
pause();
plot(out10,'DisplayName','original piano note (reverbed)');%reverbed shma
pause();
close all;

out50=out2;
y50=filter(a50,b50,out50); 
plot(y50);%teliko dereverbed
title("de-reverb filter effect on piano note wave forms (time), Delay: +50")
legend('final filtered piano note (de-reverbed)');
ylabel("amplitude");
xlabel("scaled time");
hold on;
pause();
plot(out50,'DisplayName','original piano note (reverbed)');%reverbed shma
pause();
close all;

[h1,w1]=freqz(br,ar);
plot(w1,(abs(h1)))
title("de-reverb filter effect on piano note, frequency spectrum, original delay P=850")
legend('original piano note (reverbed)');
ylabel("amplitude");
xlabel("scaled frequency");
hold on;
pause();
[h2,w2]=freqz(ar,br);
plot(w2,(abs(h2)),'DisplayName','final filtered piano note (de-reverbed)');
plot(w1,abs(h2).*abs(h1));
pause();
close all;

[h1,w1]=freqz(br,ar);
plot(w1,(abs(h1)))
title("de-reverb filter effect on piano note, frequency spectrum, Delay: +5")
legend('original piano note (reverbed)');
ylabel("amplitude");
xlabel("scaled frequency");
hold on;
pause();
[h2,w2]=freqz(a5,b5);
plot(w2,(abs(h2)),'DisplayName','final filtered piano note (de-reverbed)');
plot(w1,abs(h2).*abs(h1));
pause();
close all;

[h1,w1]=freqz(br,ar);
plot(w1,(abs(h1)));
title("de-reverb filter effect on piano note, frequency spectrum, Delay: +10")
legend('original piano note (reverbed)');
ylabel("amplitude");
xlabel("scaled frequency");
hold on;
pause();
[h2,w2]=freqz(a10,b10);
plot(w2,(abs(h2)),'DisplayName','final filtered piano note (de-reverbed)');
plot(w1,abs(h2).*abs(h1));
pause();
close all;

[h1,w1]=freqz(br,ar);
plot(w1,(abs(h1)));
title("de-reverb filter effect on piano note, frequency spectrum, Delay: +50")
legend('original piano note (reverbed)');
ylabel("amplitude");
xlabel("scaled frequency");
hold on;
pause();
[h2,w2]=freqz(a50,b50);
plot(w2,(abs(h2)),'DisplayName','final filtered piano note (de-reverbed)');
plot(w1,abs(h2).*abs(h1));
pause();
close all;



                





