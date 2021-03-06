% real function
% x = u( [0:0.0001:1] );

% blackboard
%  A = [ 356 119; 354 119; 352 119; 350 120; 347 121; 344 122; 339 124; 336 126; 332 128; 326 131; 320 134; 315 138; 310 143; 303 147; 298 151; 293 156; 292 156; 289 159; 289 162; 289 165; 286 171; 283 178; 279 185; 276 192; 275 196; 275 197; 273 200; 272 204; 272 207; 272 211; 272 216; 272 221; 272 224; 273 229; 274 234; 276 238; 278 242; 280 248; 282 251; 285 255; 287 259; 289 260; 294 264; 299 267; 302 270; 305 272; 308 273; 312 275; 316 276; 319 277; 323 278; 326 278; 329 278; 333 278; 337 278; 340 278; 343 278; 346 278; 350 278; 353 278; 358 278; 361 278; 365 278; 370 278; 375 276; 379 274; 385 272; 389 270; 394 268; 399 266; 405 263; 411 259; 416 255; 421 251; 425 247; 428 244; 431 240; 432 235; 434 232; 435 228; 436 225; 436 220; 437 215; 437 210; 437 205; 437 201; 437 196; 437 192; 437 189; 437 184; 437 180; 437 177; 435 173; 434 170; 433 167; 432 164; 431 161; 429 159; 428 157; 427 155; 426 153; 424 151; 423 149; 422 148; 421 147; 420 145; 419 144; 418 142; 417 141; 415 140; 413 139; 412 138; 410 137; 409 136; 407 134; 405 133; 404 133; 402 131; 399 130; 398 130; 396 128; 395 128; 391 127; 390 126; 389 126; 387 125; 385 124; 383 124; 382 123; 381 123; 379 122; 378 122; 377 121; 376 121; 375 121; 374 121; 372 119; 371 118; 369 118; 367 118; 365 118; 364 118; 363 118; 362 118; 360 117; 359 117; 357 117; 356 117; 355 117; 354 117; 353 117; 351 117; 350 117; 349 117; 348 116 ];  x = A(:,1)'; x = (x-min(x))/800;  y = A(:,2)'; y = -y+600; y = (y-min(y))/600;

% database
x = db.trace{3}.channel{1};
% x = (x-min(x))/(max(x)-min(x));
% x = x/(max(x)-min(x));


% x = Y;
% x = (x-min(x))/(max(x)-min(x));

global C;
% global LS_coeffs;
% global Chebyshev_coeffs;
% figure;

for N=15  %*ones(1,1000)

    C = legendre_coefficients_matrix(N);
%     LS_coeffs = legendre_sobolev_coefficients_matrix(N);
%     Chebyshev_coeffs = chebyshev_coefficients_matrix(N);
    
    % LeastSquares
    subplot(121)
    [alpha, xest] = aprox_least_squares(N,x,C);
    plot_aprox( x, xest, 'Minimos cuadrados' );
    error_minimos_cuadrado = bestfit( x, xest )
  
    
    % Legendre
    subplot(122)
    
%     L=length(x);
%     delta = 1/L;
%     t = [0:delta:1-1/L];
    
    % Discrete time
    t = 0:length(x)-1;

    [alpha2, xest2] = aprox_discrete(N,x,C,t);
    xest2 = xest2(1:end-1);
    plot_aprox( x, xest2, ['N = ',int2str(N)] );
    error_legendre = bestfit( x, xest2 )
    
    alpha2
    
%     [error_minimos_cuadrado, error_legendre]

%     pause(0.35);
end
% t_total_2 = cputime;

% [mean(time), N, t_total_2-t_total_1]

