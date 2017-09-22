%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

if isoctave || matlab_ver_less_than('8.6')
    clear all
else
    clearvars -global
    clear_persistent_variables(fileparts(which('dynare')), false)
end
tic0 = tic;
% Save empty dates and dseries objects in memory.
dates('initialize');
dseries('initialize');
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'dtclin';
M_.dynare_version = '4.5.1';
oo_.dynare_version = '4.5.1';
options_.dynare_version = '4.5.1';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('dtclin.log');
M_.exo_names = 'e_ee';
M_.exo_names_tex = 'e\_ee';
M_.exo_names_long = 'e_ee';
M_.exo_names = char(M_.exo_names, 'e_pc');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_pc');
M_.exo_names_long = char(M_.exo_names_long, 'e_pc');
M_.exo_names = char(M_.exo_names, 'e_tfp');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_tfp');
M_.exo_names_long = char(M_.exo_names_long, 'e_tfp');
M_.exo_names = char(M_.exo_names, 'e_e_mp');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_e\_mp');
M_.exo_names_long = char(M_.exo_names_long, 'e_e_mp');
M_.endo_names = 'z';
M_.endo_names_tex = 'z';
M_.endo_names_long = 'z';
M_.endo_names = char(M_.endo_names, 'y');
M_.endo_names_tex = char(M_.endo_names_tex, 'y');
M_.endo_names_long = char(M_.endo_names_long, 'y');
M_.endo_names = char(M_.endo_names, 'm');
M_.endo_names_tex = char(M_.endo_names_tex, 'm');
M_.endo_names_long = char(M_.endo_names_long, 'm');
M_.endo_names = char(M_.endo_names, 'infl');
M_.endo_names_tex = char(M_.endo_names_tex, 'infl');
M_.endo_names_long = char(M_.endo_names_long, 'infl');
M_.endo_names = char(M_.endo_names, 's');
M_.endo_names_tex = char(M_.endo_names_tex, 's');
M_.endo_names_long = char(M_.endo_names_long, 's');
M_.endo_names = char(M_.endo_names, 'tfp');
M_.endo_names_tex = char(M_.endo_names_tex, 'tfp');
M_.endo_names_long = char(M_.endo_names_long, 'tfp');
M_.endo_names = char(M_.endo_names, 'e_mp');
M_.endo_names_tex = char(M_.endo_names_tex, 'e\_mp');
M_.endo_names_long = char(M_.endo_names_long, 'e_mp');
M_.endo_partitions = struct();
M_.param_names = 'eta';
M_.param_names_tex = 'eta';
M_.param_names_long = 'eta';
M_.param_names = char(M_.param_names, 'bet');
M_.param_names_tex = char(M_.param_names_tex, 'bet');
M_.param_names_long = char(M_.param_names_long, 'bet');
M_.param_names = char(M_.param_names, 'theta');
M_.param_names_tex = char(M_.param_names_tex, 'theta');
M_.param_names_long = char(M_.param_names_long, 'theta');
M_.param_names = char(M_.param_names, 'alph');
M_.param_names_tex = char(M_.param_names_tex, 'alph');
M_.param_names_long = char(M_.param_names_long, 'alph');
M_.param_names = char(M_.param_names, 'epse');
M_.param_names_tex = char(M_.param_names_tex, 'epse');
M_.param_names_long = char(M_.param_names_long, 'epse');
M_.param_names = char(M_.param_names, 'alphC');
M_.param_names_tex = char(M_.param_names_tex, 'alphC');
M_.param_names_long = char(M_.param_names_long, 'alphC');
M_.param_names = char(M_.param_names, 'xi');
M_.param_names_tex = char(M_.param_names_tex, 'xi');
M_.param_names_long = char(M_.param_names_long, 'xi');
M_.param_names = char(M_.param_names, 'zet');
M_.param_names_tex = char(M_.param_names_tex, 'zet');
M_.param_names_long = char(M_.param_names_long, 'zet');
M_.param_names = char(M_.param_names, 'rho_tfp');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_tfp');
M_.param_names_long = char(M_.param_names_long, 'rho_tfp');
M_.param_names = char(M_.param_names, 'tfpbar');
M_.param_names_tex = char(M_.param_names_tex, 'tfpbar');
M_.param_names_long = char(M_.param_names_long, 'tfpbar');
M_.param_names = char(M_.param_names, 'gammma');
M_.param_names_tex = char(M_.param_names_tex, 'gammma');
M_.param_names_long = char(M_.param_names_long, 'gammma');
M_.param_names = char(M_.param_names, 'rho_mp');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_mp');
M_.param_names_long = char(M_.param_names_long, 'rho_mp');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 4;
M_.endo_nbr = 7;
M_.param_nbr = 12;
M_.orig_endo_nbr = 7;
M_.aux_vars = [];
M_.predetermined_variables = [ 1 ];
M_.Sigma_e = zeros(4, 4);
M_.Correlation_matrix = eye(4, 4);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.linear = 1;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 1;
erase_compiled_function('dtclin_static');
erase_compiled_function('dtclin_dynamic');
M_.orig_eq_nbr = 7;
M_.eq_nbr = 7;
M_.ramsey_eq_nbr = 0;
M_.lead_lag_incidence = [
 1 4 0;
 0 5 11;
 0 6 0;
 0 7 12;
 0 8 0;
 2 9 0;
 3 10 0;]';
M_.nstatic = 2;
M_.nfwrd   = 2;
M_.npred   = 3;
M_.nboth   = 0;
M_.nsfwrd   = 2;
M_.nspred   = 3;
M_.ndynamic   = 5;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:4];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(7, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(4, 1);
M_.params = NaN(12, 1);
M_.NNZDerivatives = [25; -1; -1];
M_.params( 1 ) = 1.39;
eta = M_.params( 1 );
M_.params( 2 ) = .9975;
bet = M_.params( 2 );
M_.params( 3 ) = 0;
theta = M_.params( 3 );
M_.params( 6 ) = 0.75;
alphC = M_.params( 6 );
M_.params( 4 ) = 0.8333333333333334;
alph = M_.params( 4 );
M_.params( 9 ) = .5;
rho_tfp = M_.params( 9 );
M_.params( 5 ) = 6;
epse = M_.params( 5 );
M_.params( 7 ) = 1;
xi = M_.params( 7 );
M_.params( 8 ) = .6;
zet = M_.params( 8 );
M_.params( 10 ) = 1;
tfpbar = M_.params( 10 );
M_.params( 11 ) = 0.6666666666666666;
gammma = M_.params( 11 );
M_.params( 12 ) = .75;
rho_mp = M_.params( 12 );
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (.000)^2;
M_.Sigma_e(2, 2) = (.000)^2;
M_.Sigma_e(3, 3) = (1)^2;
M_.Sigma_e(4, 4) = (1)^2;
oo_.dr.eigval = check(M_,options_,oo_);
options_.drop = 10000;
options_.irf = 30;
options_.order = 1;
options_.periods = 50000;
options_.replic = 100;
options_.solve_algo = 2;
var_list_ = char('y','m','infl','z');
info = stoch_simul(var_list_);
save('dtclin_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('dtclin_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('dtclin_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('dtclin_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('dtclin_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('dtclin_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('dtclin_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
