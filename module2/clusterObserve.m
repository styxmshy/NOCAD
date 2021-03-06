function [ clusterObs ] = clusterObserve( Amatrix, Cmatrix )
%CLUSTEROBSERVE creates a matrix, which can shows that how a
% sensor node observe the nodes and that how many derives needed to
% apperances the state on the sensor. In i. row, the j. column shows how
% many derives need to appeare the information of state i. on sensor j.
% ##################
% Example:
% ##################
% Inputs: 
%
% Amatrix=[0 0 0 0; 1 0 0 0; 0 1 0 0; 1 0 0 0]; % could be sparse
% Cmatrix=[0 0 1 0; 0 0 0 1];                   % could be sparse
% ##################
% Function Calling:
%
% clusterObs=clusterObserve(Amatrix, Cmatrix)
% ##################
% Output:
%
% clusterObs =
% 
%      0     0     3     2
%      0     0     2     0
%      0     0     1     0
%      0     0     0     1
% ##################
%  The algorithm was implemented by Daniel Leitold 
   
   if ~exist('all_shortest_paths', 'file')
     mfilepath=fileparts(which('clusterObserve'));
     addpath([mfilepath,'\..\matlab_bgl']);
   end
   
   % determine driver nodes
   nonSensorNodes=sum(Cmatrix,1)==0;
   
   % generate the shortest paths
   if issparse(Amatrix)
      clusterObs=sparse(all_shortest_paths(Amatrix')+1);
   else
      clusterObs=all_shortest_paths(sparse(Amatrix'))+1;
   end
   clusterObs(clusterObs==Inf)=0;
   
   % finalize the output matrix
   clusterObs(:,nonSensorNodes)=0;
   
end

