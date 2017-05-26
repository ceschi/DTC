%
% Status : main Dynare file 
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

clear all
tic;
global M_ oo_ options_ ys0_ ex0_ estimation_info
options_ = [];
M_.fname = 'DTC_AR';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('DTC_AR.log');
M_.exo_names = 'shock_e_ee';
M_.exo_names_tex = 'shock\_e\_ee';
M_.exo_names_long = 'shock_e_ee';
M_.exo_names = char(M_.exo_names, 'shock_e_pc');
M_.exo_names_tex = char(M_.exo_names_tex, 'shock\_e\_pc');
M_.exo_names_long = char(M_.exo_names_long, 'shock_e_pc');
M_.exo_names = char(M_.exo_names, 'e_out');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_out');
M_.exo_names_long = char(M_.exo_names_long, 'e_out');
M_.endo_names = 'z';
M_.endo_names_tex = 'z';
M_.endo_names_long = 'z';
M_.endo_names = char(M_.endo_names, 'c');
M_.endo_names_tex = char(M_.endo_names_tex, 'c');
M_.endo_names_long = char(M_.endo_names_long, 'c');
M_.endo_names = char(M_.endo_names, 'm');
M_.endo_names_tex = char(M_.endo_names_tex, 'm');
M_.endo_names_long = char(M_.endo_names_long, 'm');
M_.endo_names = char(M_.endo_names, 'infl');
M_.endo_names_tex = char(M_.endo_names_tex, 'infl');
M_.endo_names_long = char(M_.endo_names_long, 'infl');
M_.endo_names = char(M_.endo_names, 'output');
M_.endo_names_tex = char(M_.endo_names_tex, 'output');
M_.endo_names_long = char(M_.endo_names_long, 'output');
M_.endo_names = char(M_.endo_names, 'e_ee');
M_.endo_names_tex = char(M_.endo_names_tex, 'e\_ee');
M_.endo_names_long = char(M_.endo_names_long, 'e_ee');
M_.endo_names = char(M_.endo_names, 'e_pc');
M_.endo_names_tex = char(M_.endo_names_tex, 'e\_pc');
M_.endo_names_long = char(M_.endo_names_long, 'e_pc');
M_.param_names = 'eta';
M_.param_names_tex = 'eta';
M_.param_names_long = 'eta';
M_.param_names = char(M_.param_names, 'bet');
M_.param_names_tex = char(M_.param_names_tex, 'bet');
M_.param_names_long = char(M_.param_names_long, 'bet');
M_.param_names = char(M_.param_names, 'theta');
M_.param_names_tex = char(M_.param_names_tex, 'theta');
M_.param_names_long = char(M_.param_names_long, 'theta');
M_.param_names = char(M_.param_names, 'mu');
M_.param_names_tex = char(M_.param_names_tex, 'mu');
M_.param_names_long = char(M_.param_names_long, 'mu');
M_.param_names = char(M_.param_names, 'rho');
M_.param_names_tex = char(M_.param_names_tex, 'rho');
M_.param_names_long = char(M_.param_names_long, 'rho');
M_.param_names = char(M_.param_names, 'sigm');
M_.param_names_tex = char(M_.param_names_tex, 'sigm');
M_.param_names_long = char(M_.param_names_long, 'sigm');
M_.param_names = char(M_.param_names, 'chi');
M_.param_names_tex = char(M_.param_names_tex, 'chi');
M_.param_names_long = char(M_.param_names_long, 'chi');
M_.param_names = char(M_.param_names, 'rho_pc_s');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_pc\_s');
M_.param_names_long = char(M_.param_names_long, 'rho_pc_s');
M_.param_names = char(M_.param_names, 'rho_ee_s');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_ee\_s');
M_.param_names_long = char(M_.param_names_long, 'rho_ee_s');
M_.param_names = char(M_.param_names, 'ybar');
M_.param_names_tex = char(M_.param_names_tex, 'ybar');
M_.param_names_long = char(M_.param_names_long, 'ybar');
M_.exo_det_nbr = 0;
M_.exo_nbr = 3;
M_.endo_nbr = 7;
M_.param_nbr = 10;
M_.orig_endo_nbr = 7;
M_.aux_vars = [];
M_.predetermined_variables = [ 1 ];
M_.Sigma_e = zeros(3, 3);
M_.Correlation_matrix = eye(3, 3);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
erase_compiled_function('DTC_AR_static');
erase_compiled_function('DTC_AR_dynamic');
M_.lead_lag_incidence = [
 1 5 0;
 0 6 12;
 0 7 0;
 0 8 13;
 2 9 0;
 3 10 0;
 4 11 0;]';
M_.nstatic = 1;
M_.nfwrd   = 2;
M_.npred   = 4;
M_.nboth   = 0;
M_.nsfwrd   = 2;
M_.nspred   = 4;
M_.ndynamic   = 6;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:3];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(7, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(3, 1);
M_.params = NaN(10, 1);
M_.NNZDerivatives = zeros(3, 1);
M_.NNZDerivatives(1) = 26;
M_.NNZDerivatives(2) = -1;
M_.NNZDerivatives(3) = -1;
M_.params( 1 ) = 1.39;
eta = M_.params( 1 );
M_.params( 2 ) = 0.975;
bet = M_.params( 2 );
M_.params( 4 ) = 0.93;
mu = M_.params( 4 );
M_.params( 5 ) = .97;
rho = M_.params( 5 );
M_.params( 7 ) = .95;
chi = M_.params( 7 );
M_.params( 10 ) = 1;
ybar = M_.params( 10 );
M_.params( 9 ) = .85;
rho_ee_s = M_.params( 9 );
M_.params( 8 ) = .85;
rho_pc_s = M_.params( 8 );
M_.params( 6 ) = 1.5;
sigm = M_.params( 6 );
M_.params( 3 ) = .1;
theta = M_.params( 3 );
%
% SHOCKS instructions
%
make_ex_;
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (.1)^2;
M_.Sigma_e(2, 2) = (.1)^2;
M_.Sigma_e(3, 3) = (.01)^2;
options_.qz_zero_threshold = 1e-10;
options_.solve_algo = 2;
oo_.dr.eigval = check(M_,options_,oo_);
options_.irf = 10;
options_.nocorr = 1;
options_.order = 1;
options_.periods = 50000;
options_.solve_algo = 2;
var_list_=[];
info = stoch_simul(var_list_);
save('DTC_AR_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('DTC_AR_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('DTC_AR_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('DTC_AR_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('DTC_AR_results.mat', 'estimation_info', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
