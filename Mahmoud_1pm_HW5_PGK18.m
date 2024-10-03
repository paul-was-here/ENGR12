disp('I, Paul Kullmann, certify that I have completed this assignment in an honest manner.')
%Paul Kullmann

while true
    [filename] = function1;
    data = load(filename);
    
    choice = menu('Choose some statistical information:','Mean','Standard Deviaion','Variance','Minimum','Maximum');
    switch choice
        case 1 % Mean
            dmean = mean(data(:,2));
            function2('Mean',dmean)
        case 2 % Standard Deviation
            dstd = std(data(:,2));
            function2('Standard Deviation',dstd)
        case 3 % Variance
            dvar = var(data(:,2));
            function2('Variance',dvar)
        case 4 % Minimum
            dmin = min(data(:,2));
            function2('Minimum',dmin)
        case 5 % Maximum
            dmax = max(data(:,2));
            function2('Maximum',dmax)
    end
    
    function3(data)
    
    [numcount,numtolookfor] = function4(data);
    disp(['The number ',num2str(numtolookfor),' appears ',num2str(numcount),' times.'])

    runagain = menu('Would you like to run the program again?','Yes','No');
    switch runagain
        case 1
            clc
            clear
        case 2
            return
    end 
end


%%%%%% Functions

%Function 1: finding the file
function [filename] = function1
    while true
        userin = input('Enter a file name: ','s');
        if exist(userin) == 2
            filename = userin;
            break
        else
            disp('File not found.')
        end
    end
end

%Function 2: displaying the user's choice
function function2(choice,val)
    disp(['The ',choice,' of the data is ',num2str(val)])
end

%Function 3: Creating plots
function function3(data)

    %Plotting the data
    subplot(4,1,1)
    plot(data(:,1),data(:,2),'yo')
    title(input('Enter a title for the first plot: ','s'))
    xlabel(input('Enter a label for the X-axis: ','s'))
    ylabel(input('Enter a label for the Y-axis: ','s'))

    %YouTube Logo picture
    subplot(4,1,2)
    pic = imread('Pic.jpg');
    imshow(pic)

    %Histogram
    subplot(4,1,3)
    histogram(data,10)
    title('Histogram of Data')

    %Fucked up house subplot
    subplot(4,1,4)
    house = imread('House.jpg');
    house = house + 100;
    house = rot90(house);
    house = rot90(house);
    [rows,cols,color] = size(house);
    cut1 = house(1:rows/2,:,:);
    cut2 = house(rows/2+1:rows,:,:);
    newhouse = vertcat(cut2,cut1);
    imshow(newhouse)

    %User slapping their name on it
    ginput = input('Enter your name: ','s');
    gtext(ginput)

end

%Function 4: Counting the number of times any number appears
function [numcount,numtolookfor] = function4(data)
    [rows,cols] = size(data);
    numtolookfor = input('Enter a number to search for: ');
    numcount = 0;
    for i = 1:1:rows
        cell = num2str(data(i,1));
        for j = 1:length(cell)
            if str2num(cell(j)) == numtolookfor
                numcount = numcount + 1;
            end
        end
    end
    for i = 1:1:rows
        cell = num2str(data(i,2));
        for j = 1:length(cell)
            if str2num(cell(j)) == numtolookfor
                numcount = numcount + 1;
            end
        end
    end
%idk this probably wasnt the best way to do it? but only way i could think
%of. if you (TA) are even reading this lol
end

