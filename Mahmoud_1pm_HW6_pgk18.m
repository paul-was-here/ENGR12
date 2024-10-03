disp('I, Paul Kullmann, certify that I have completed this assignment in an honest manner.')

% It seems like a 9th order polynomial provides the best fit for the first
% data set. The R^2 value gets closer to 1 the higher the order goes (odd).
% With a 9th order, the R^2 value is 0.9957 compared to 0.991 for 3rd
% order.

% A 10th order polynomial provides th ebest fit for the second data set
% with an R^2 value of 0.9999. The R^2 increases the higher the order
% polynomial (even).

header()

%%% Program
while true % Looping if the user wants to run again
    while true % Looping until a valid file name is given
        filename = input('Enter a file name: ','s');
        if exist(filename) == 2
            data = load(filename);
            break
        else
            disp('File not found.')
        end
    end
    
    [rows,cols] = size(data); 
    if rows == 2 %Identifying the data size
        disp(['The data is 2 rows and ',num2str(cols),' columns.'])
        x = data(1,:);
        y = data(2,:);
    elseif cols == 2
        disp(['The data is 2 columns and ',num2str(rows),' rows.'])
        x = data(:,1);
        y = data(:,2);
    else
        disp('The data is neither 2 rows nor 2 columns.')
    end 
    
    [choice] = plotting(x,y);
    switch choice %Giving the user the illusion of choice
        case 1
            [abserror,errorx] = LinearFit(x,y);
            disp(['The largest absolute error is ',num2str(abserror),' and its location is x = ',num2str(errorx)])
        case 2
            [abserror,errorx] = PolynomialFit(x,y);
            disp(['The largest absolute error is ',num2str(abserror),' and its location is x = ',num2str(errorx)])
    end

    goagain = input('Would you like to run the program again with new data? y/n: ','s');
    if goagain == 'n'
        return
    else
    end
end 

%%%%%%%%%%% Functions
%Header function
function header
    disp('Paul Kullmann, Team 13')
end

%Plotting function
function [choice] = plotting(x,y)
    plot(x,y,'ro')
    hold on
    title(input('Enter a title: ','s'))
    xlabel(input('Enter a label for the X-Axis: ','s'))
    ylabel(input('Enter a label for the Y-Axis: ','s'))
    
    pause(5);
    
    choice = menu('Choose a data fit: ','Linear','Polynomial');
end

%Linear Fit Function
function [abserror,errorx] = LinearFit(x,y) %Fitting a linear curve
    coeffs = polyfit(x,y,1);
    liny = x*coeffs(1) + coeffs(2);
    plot(x,liny,'-k')
    title('Linear Fit')
    gtext(['y = ',num2str(coeffs(1)),'*x + ',num2str(coeffs(2))])

    abserror = 0; 
    errorx = 0;
    for i = 1:size(x) %Finding the largest error
        if abs(liny(i) - y(i)) > abserror
            abserror = abs(liny(i) - y(i));
            errorx = x(i);
        end
    end

    sse = sum((y-liny).^2); % Finding R^2
    sst = sum((y-mean(y)).^2);
    rsq = 1-sse/sst;
    gtext(['R^2 = ',num2str(rsq)])


    while true
        yesorno = input('Would you like to find an estimated y value? ','s'); %Estimating y
        if yesorno == 'y'
            xtoestimate = input('Enter an x value: ');
            estimatedy = xtoestimate*coeffs(1) + coeffs(2);
            disp(['The estimate of y for x = ',num2str(xtoestimate),' is ',num2str(estimatedy)])
                break
        elseif yesorno == 'n'
            break
        else
            disp('Invalid input. y or n only.')
        end
    end
end

% Polynomial Fit Function
function [abserror,errorx] = PolynomialFit(x,y) % Getting an order input
    while true
        order = input('Enter an order for the polynomial, between 2 and 10: ');
        if order >= 2 && order <= 10
            break
        else
            disp('Not between 2 and 10.')
        end
    end
    coeffs = polyfit(x,y,order); % Fitting the data
    polyy = polyval(coeffs,linspace(min(x),max(x),300));
    polyybutnot300xvalues = polyval(coeffs,x);
    plot(linspace(min(x),max(x),300),polyy,'g-')
    title('Polynomial Fit')

    abserror = 0;
    errorx = 0;
    for i = 1:length(x) % Finding the largest error
        if abs(polyybutnot300xvalues(i) - y(i)) > abserror
            abserror = abs(polyybutnot300xvalues(i) - y(i));
            errorx = x(i);
        end
    end

    sse = sum((y-polyybutnot300xvalues).^2); % Finding R^2
    sst = sum((y-mean(y)).^2);
    rsq = 1-sse/sst;
    gtext(['R^2 = ',num2str(rsq)])

    while true 
        choice = input('Would you like to estimate a y for a given x? ','s'); % Asking to estimate y or not
        if choice == 'y'
            xtoestimate = input('Enter an x value to estimate: ');
            estimatedy = polyval(coeffs,xtoestimate);
            disp(['The estimate of y for x = ',num2str(xtoestimate),' is ',num2str(estimatedy)])
            break
        elseif choice == 'n'
            break
        else
            disp('Invalid input. y or n only.')
        end
    end
end