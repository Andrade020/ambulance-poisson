
function [x,fVal]=projectedGradientMissingLocation(nbObservations,nbCalls,nb_missing_calls,neighbors,G,T,R,C,sigma,x,prob,iterMax,alpha,epsilon,durations,Groups,whichgroup,weight)

k=1;
fVal=[];
bparam=2;
betak=bparam;

[fold,fpold]=oracleObjectiveMissing(nbObservations,nbCalls,nb_missing_calls,neighbors,x,prob,T,R,C,G,alpha,durations,Groups,whichgroup,weight);
[gradientl,gradientp]=oracleGradientMissing(nbObservations,nbCalls,nb_missing_calls,neighbors,x,prob,G,T,R,C,alpha,durations,Groups,whichgroup,weight);
                     
while (k<=iterMax)
    k
    z=max(x-betak*gradientl,epsilon);
    rhs=sum(sum(sum(sum(gradientl.*(x-z)))));
    [fL,fp]=oracleObjectiveMissing(nbObservations,nbCalls,nb_missing_calls,neighbors,z,prob,T,R,C,G,alpha,durations,Groups,whichgroup,weight);
    if (fL>fold-sigma*rhs)
        bool=1;
        j=1;
        while (bool==1)
            zAux=x+(1/(2^j))*(z-x);
            [fL,fp]=oracleObjectiveMissing(nbObservations,nbCalls,nb_missing_calls,neighbors,zAux,prob,T,R,C,G,alpha,durations,Groups,whichgroup,weight);            
            if (fL<=fold-(sigma/2^j)*rhs)
                bool=0;
            else
                j=j+1;
            end
        end
        x=zAux;
        betak=bparam/2^(j-1);
    else
        x=z;
        j=1;
        betak=2*betak;
    end
    fVal=[fVal,fL];
    fold=fL;
    [gradientl,gradientp]=oracleGradientMissing(nbObservations,nbCalls,nb_missing_calls,neighbors,x,prob,G,T,R,C,alpha,durations,Groups,whichgroup,weight);    
    k=k+1;
end
