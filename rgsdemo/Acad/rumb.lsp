;;;=========================================================================
;;;=========================================================================
;;;=========================================================================
;;;=========================================================================
;;;=========================================================================
(defun C:KR ()
   (setq kr_dcl (load_dialog "rumb.dcl"))
   (if (not (new_dialog "kriv" kr_dcl))
      (exit)
   )
   (set_tile "gp_scale" "1000")
   (set_tile "gp_kr_R" "100")
   (set_tile "gp_kr_l" "20")
   (set_tile "gp_kr_seg" "1")
   (set_tile "gp_rad_circle" "0.5")								    ; Определение отрисовки названия
   (setq kr_vntk "1")
   (action_tile "gp_vntk_on" "(setq kr_vntk \"1\")")
   (action_tile "gp_vntk_off" "(setq kr_vntk \"2\")")
												    ; Определение отрисовки координат
   (setq kr_vcoor "2")
   (action_tile "gp_vcoor_on" "(setq kr_vcoor \"1\")")
   (action_tile "gp_vcoor_off" "(setq kr_vcoor \"2\")")
												    ; Определение отрисовки точки
   (setq kr_vcircle "1")
   (action_tile "gp_vcircle_on" "(setq kr_vcircle \"1\")")
   (action_tile "gp_vcircle_off" "(setq kr_vcircle \"2\")")
												    ; Определение отрисовки общих данных
   (setq kr_vdod "2")
   (action_tile "gp_vdod_on" "(setq kr_vdod \"1\")")
   (action_tile "gp_vdod_off" "(setq kr_vdod \"2\")")
												    ; Определение отрисовки общих данных
   (setq kr_vdpk "2")
   (action_tile "gp_vdpk_on" "(setq kr_vdpk \"1\")")
   (action_tile "gp_vdpk_off" "(setq kr_vdpk \"2\")")
												    ;Определение кнопки "Нет"
   (action_tile "cancel" "(done_dialog)(exit)")
												    ;Определение кнопки "Да"
   (action_tile
      "accept"
      (strcat
	 "(setq kr_scale (atof (get_tile \"gp_scale\")))" "(setq kr_R (atof (get_tile \"gp_kr_R\")))" "(setq kr_l (atof (get_tile \"gp_kr_l\")))"
	 "(setq kr_seg (atof (get_tile \"gp_kr_seg\")))" "(setq kr_rad_circle (atof (get_tile \"gp_rad_circle\")))" "(done_dialog)"
	)
   )
   (start_dialog)
   (unload_dialog kr_dcl)
   (setq kr_scale (/ kr_scale 1000))
   (setq kr_point_1 (getpoint "\nУкажите точку на первой прямой:"))
   (setq kr_vu (getpoint "\nУкажите вершину угла:"))
   (setq kr_point_2 (getpoint "\nУкажите точку на второй прямой:"))
   (setq rumb_osmode (getvar "osmode"))
   (setvar "osmode" 0)
												    ;-----------------------------------------------------------------------------------
												    ;Вычисление дир. углов и угла поворота
   (setq kr_dir_1 (- (* 2.5 pi) (angle kr_point_1 kr_vu)))
   (setq kr_dir_2 (- (* 2.5 pi) (angle kr_vu kr_point_2)))
   (setq kr_ug (- kr_dir_2 kr_dir_1))
   (if (< pi kr_ug)
      (setq kr_ug (- kr_ug (* 2 pi)))
   )
   (if (< kr_ug (* -1 pi))
      (setq kr_ug (+ kr_ug (* 2 pi)))
   )												    ;Вычисление тангенса и биссектрисы
   (setq kr_T
	   (+ (+ (abs (* kr_R (/ (sin (/ kr_ug 2)) (cos (/ kr_ug 2)))))
		 (* (/ kr_l 2)
		    (+ (- 1 (/ (expt kr_l 2) (* 120 (expt kr_R 2)))) (/ (expt kr_l 4) (* 17280 (expt kr_R 4))))
		 )
	      )
	      (* (* (/ (expt kr_l 2) (* 24 kr_R))
		    (+ (- 1 (/ (expt kr_l 2) (* 112 (expt kr_R 2)))) (/ (expt kr_l 4) (* 21120 (expt kr_R 4))))
		 )
		 (abs (/ (sin (/ kr_ug 2)) (cos (/ kr_ug 2))))
	      )
	   )
   )
   (setq kr_B (+ (* kr_R (- (/ 1 (cos (/ (abs kr_ug) 2))) 1))
		 (* (* (/ (expt kr_l 2) (* 24 kr_R))
		       (+ (- 1 (/ (expt kr_l 2) (* 112 (expt kr_R 2)))) (/ (expt kr_l 4) (* 21120 (expt kr_R 4))))
		    )
		    (/ 1 (cos (/ (abs kr_ug) 2)))
		 )
	      )
   )												    ;Вычисление координат начала, середины и конца кривой
   (if (< kr_ug 0)
      (progn
	 (setq kr_Xnk (+ (cadr kr_vu) (* (- kr_T) (cos kr_dir_1))))
	 (setq kr_Ynk (+ (car kr_vu) (* (- kr_T) (sin kr_dir_1))))
	 (setq kr_Xkk (+ (cadr kr_vu) (* (- kr_T) (cos (- kr_dir_2 pi)))))
	 (setq kr_Ykk (+ (car kr_vu) (* (- kr_T) (sin (- kr_dir_2 pi)))))
	 (setq kr_Xsk (+ (cadr kr_vu) (* kr_B (cos (- kr_dir_2 (/ (- pi (abs kr_ug)) 2))))))
	 (setq kr_Ysk (+ (car kr_vu) (* kr_B (sin (- kr_dir_2 (/ (- pi (abs kr_ug)) 2))))))
      )
      (progn
	 (setq kr_Xnk (+ (cadr kr_vu) (* kr_T (cos (- kr_dir_1 pi)))))
	 (setq kr_Ynk (+ (car kr_vu) (* kr_T (sin (- kr_dir_1 pi)))))
	 (setq kr_Xkk (+ (cadr kr_vu) (* kr_T (cos kr_dir_2))))
	 (setq kr_Ykk (+ (car kr_vu) (* kr_T (sin kr_dir_2))))
	 (setq kr_Xsk (+ (cadr kr_vu) (* kr_B (cos (+ kr_dir_2 (/ (- pi kr_ug) 2))))))
	 (setq kr_Ysk (+ (car kr_vu) (* kr_B (sin (+ kr_dir_2 (/ (- pi kr_ug) 2))))))
      )
   )
   (setq kr_K (+ kr_l (abs (* kr_R kr_ug))))
   (setq kr_D (- (abs (* 2 kr_T)) kr_K))
   (if (or (= kr_vdod "1") (= kr_vdpk "1"))
      (setq kr_tvd
	      (getpoint "\nУкажите точку вставки экспликации:")
      )
   )
   (if (= kr_vdod "1")
      (progn
	 (setq kr_tvd (list (car kr_tvd)
			    (- (cadr kr_tvd) (* 3 kr_scale))
		      )
	 )
	 (command "_text"
		  kr_tvd
		  (* 2 kr_scale)
		  "0"
		  (strcat "A = " (angtos (abs kr_ug) 1 4))
	 )
	 (setq kr_tvd (list (car kr_tvd) (- (cadr kr_tvd) (* 3 kr_scale))))
	 (command "_text"
		  kr_tvd
		  (* 2 kr_scale)
		  "0"
		  (strcat "R = " (rtos kr_R 2 3))
	 )
	 (setq kr_tvd (list (car kr_tvd) (- (cadr kr_tvd) (* 3 kr_scale))))
	 (command "_text"
		  kr_tvd
		  (* 2 kr_scale)
		  "0"
		  (strcat "T = " (rtos (abs kr_T) 2 3))
	 )
	 (setq kr_tvd (list (car kr_tvd) (- (cadr kr_tvd) (* 3 kr_scale))))
	 (command "_text"
		  kr_tvd
		  (* 2 kr_scale)
		  "0"
		  (strcat "K = " (rtos kr_K 2 3))
	 )
	 (setq kr_tvd (list (car kr_tvd) (- (cadr kr_tvd) (* 3 kr_scale))))
	 (command "_text"
		  kr_tvd
		  (* 2 kr_scale)
		  "0"
		  (strcat "l = " (rtos kr_l 2 3))
	 )
	 (setq kr_tvd (list (car kr_tvd) (- (cadr kr_tvd) (* 3 kr_scale))))
	 (command "_text"
		  kr_tvd
		  (* 2 kr_scale)
		  "0"
		  (strcat "Д = " (rtos kr_D 2 3))
	 )
	 (setq kr_tvd (list (car kr_tvd) (- (cadr kr_tvd) (* 3 kr_scale))))
	 (command "_text"
		  kr_tvd
		  (* 2 kr_scale)
		  "0"
		  (strcat "Б = " (rtos kr_B 2 3))
	 )
      )
   )
   (if (= kr_vdpk "1")
      (progn
	 (setq kr_tvd (list (car kr_tvd) (- (cadr kr_tvd) (* 6 kr_scale))))
	 (command "_text"
		  kr_tvd
		  (* 2 kr_scale)
		  "0"
		  "Ведомость элементов переходной кривой"
	 )
      )
   )
   (setq kr_k 0)
   (setq kr_Npline (list  (list 'list kr_Ynk kr_Xnk)))
   (setq kr_Kpline (list  (list 'list kr_Ykk kr_Xkk)))
   (if (= kr_l 0)
      (KR3)
   )
   (KR1)
   (setvar "osmode" rumb_osmode)
)
;;;--------------------------------------------------------------------------------------------------------------------------
(defun KR1 ()
   (setq kr_k (+ kr_seg kr_k))
   (if (>= kr_k kr_l)
      (setq kr_k kr_l)
   )
   (setq kr_xpk	(* kr_k
		   (+ (- 1 (/ (expt kr_k 4) (* 40 (* (expt kr_R 2) (expt kr_l 2)))))
		      (/ (expt kr_k 8) (* 3456 (* (expt kr_R 4) (expt kr_l 4))))
		   )
		)
   )
   (setq kr_ypk	(* (/ (expt kr_k 3) (* 6 (* kr_R kr_l)))
		   (+ (- 1 (/ (expt kr_k 4) (* 56 (* (expt kr_R 2) (expt kr_l 2)))))
		      (/ (expt kr_k 8) (* 7040 (* (expt kr_R 4) (expt kr_l 4))))
		   )
		)
   )
   (if (< kr_ug 0)
      (progn
	 (setq kr_NXpk (+ kr_Xnk (+ (* kr_xpk (cos kr_dir_1)) (* kr_ypk (cos (- kr_dir_1 (/ pi 2)))))))
	 (setq kr_NYpk (+ kr_Ynk (+ (* kr_xpk (sin kr_dir_1)) (* kr_ypk (sin (- kr_dir_1 (/ pi 2)))))))
	 (setq kr_KXpk (- kr_Xkk (- (* kr_xpk (cos kr_dir_2)) (* kr_ypk (cos (- kr_dir_2 (/ pi 2)))))))
	 (setq kr_KYpk (- kr_Ykk (- (* kr_xpk (sin kr_dir_2)) (* kr_ypk (sin (- kr_dir_2 (/ pi 2)))))))
      )
      (progn
	 (setq kr_NXpk (+ kr_Xnk (- (* kr_xpk (cos kr_dir_1)) (* kr_ypk (cos (- kr_dir_1 (/ pi 2)))))))
	 (setq kr_NYpk (+ kr_Ynk (- (* kr_xpk (sin kr_dir_1)) (* kr_ypk (sin (- kr_dir_1 (/ pi 2)))))))
	 (setq kr_KXpk (- kr_Xkk (+ (* kr_xpk (cos kr_dir_2)) (* kr_ypk (cos (- kr_dir_2 (/ pi 2)))))))
	 (setq kr_KYpk (- kr_Ykk (+ (* kr_xpk (sin kr_dir_2)) (* kr_ypk (sin (- kr_dir_2 (/ pi 2)))))))
      )
   )
   (setq kr_Npline (append kr_Npline (list (list 'list kr_NYpk kr_NXpk))))
   (setq kr_Kpline (append kr_Kpline (list (list 'list kr_KYpk kr_KXpk))))
   (if (= kr_vdpk "1")
      (progn
	 (setq kr_tvd (list (car kr_tvd) (- (cadr kr_tvd) (* 3 kr_scale))))
	 (command "_text"
		  kr_tvd
		  (* 2 kr_scale)
		  "0"
		  (rtos kr_k 2 3)
	 )
	 (command "_text"
		  (list (+ (car kr_tvd) (* 15 kr_scale)) (cadr kr_tvd))
		  (* 2 kr_scale)
		  "0"
		  (rtos kr_xpk 2 3)
	 )
	 (command "_text"
		  (list (+ (car kr_tvd) (* 30 kr_scale)) (cadr kr_tvd))
		  (* 2 kr_scale)
		  "0"
		  (rtos kr_ypk 2 3)
	 )
      )
   )
   (if (>= kr_k kr_l)
      (KR3)
   )
   (KR2)
)
;;;                                                                                                
(defun KR2 () (KR1))
;;;                                                                                                
(defun KR3 ()
   (eval (append (list 'command '"_PLINE") kr_Npline (list '"")))
   (eval (append (list 'command '"_PLINE") kr_Kpline (list '"")))
   (if (< kr_ug 0)
      (command "_arc"
	       (list kr_NYpk kr_NXpk)
	       "_e"
	       (list kr_KYpk kr_KXpk)
	       "_r"
	       kr_R
      )
      (command "_arc"
	       (list kr_KYpk kr_KXpk)
	       "_e"
	       (list kr_NYpk kr_NXpk)
	       "_r"
	       kr_R
      )
   )
   (if (= kr_vcircle "1")
      (progn (command "_circle"
		      (list kr_Ynk kr_Xnk)
		      (* kr_rad_circle kr_scale)
	     )
	     (command "_circle"
		      (list kr_Ykk kr_Xkk)
		      (* kr_rad_circle kr_scale)
	     )
	     (command "_circle"
		      (list kr_Ysk kr_Xsk)
		      (* kr_rad_circle kr_scale)
	     )
	     (command "_circle"
		      (list kr_NYpk kr_NXpk)
		      (* kr_rad_circle kr_scale)
	     )
	     (command "_circle"
		      (list kr_KYpk kr_KXpk)
		      (* kr_rad_circle kr_scale)
	     )
      )
   )
   (if (= kr_vntk "1")
      (if (= kr_l 0)
	 (progn	(command
		   "_text"
		   (list (+ kr_Ynk (* 1 kr_scale)) (+ kr_Xnk (* 1 kr_scale)))
		   (* 2 kr_scale)
		   "0"
		   "НК"
		)
		(command
		   "_text"
		   (list (+ kr_Ykk (* 1 kr_scale)) (+ kr_Xkk (* 1 kr_scale)))
		   (* 2 kr_scale)
		   "0"
		   "КК"
		)
		(command
		   "_text"
		   (list (+ kr_Ysk (* 1 kr_scale)) (+ kr_Xsk (* 1 kr_scale)))
		   (* 2 kr_scale)
		   "0"
		   "СК"
		)
	 )
	 (progn
	    (command
	       "_text"
	       (list (+ kr_Ynk (* 1 kr_scale)) (+ kr_Xnk (* 1 kr_scale)))
	       (* 2 kr_scale)
	       "0"
	       "НПК"
	    )
	    (command
	       "_text"
	       (list (+ kr_Ykk (* 1 kr_scale)) (+ kr_Xkk (* 1 kr_scale)))
	       (* 2 kr_scale)
	       "0"
	       "КПК"
	    )
	    (command
	       "_text"
	       (list (+ kr_Ysk (* 1 kr_scale)) (+ kr_Xsk (* 1 kr_scale)))
	       (* 2 kr_scale)
	       "0"
	       "СК"
	    )
	    (command
	       "_text"
	       (list (+ kr_NYpk (* 1 kr_scale)) (+ kr_NXpk (* 1 kr_scale)))
	       (* 2 kr_scale)
	       "0"
	       "НКК"
	    )
	    (command
	       "_text"
	       (list (+ kr_KYpk (* 1 kr_scale)) (+ kr_KXpk (* 1 kr_scale)))
	       (* 2 kr_scale)
	       "0"
	       "ККК"
	    )
	 )
      )
   )
   (if (= kr_vcoor "1")
      (progn
	 (command
	    "_text"
	    (list (+ kr_Ynk (* 1 kr_scale)) (+ kr_Xnk (* -2 kr_scale)))
	    (* 2 kr_scale)
	    "0"
	    (rtos kr_Xnk 2 3)
	 )
	 (command
	    "_text"
	    (list (+ kr_Ynk (* 1 kr_scale)) (+ kr_Xnk (* -5 kr_scale)))
	    (* 2 kr_scale)
	    "0"
	    (rtos kr_Ynk 2 3)
	 )
	 (command
	    "_text"
	    (list (+ kr_Ykk (* 1 kr_scale)) (+ kr_Xkk (* -2 kr_scale)))
	    (* 2 kr_scale)
	    "0"
	    (rtos kr_Xkk 2 3)
	 )
	 (command
	    "_text"
	    (list (+ kr_Ykk (* 1 kr_scale)) (+ kr_Xkk (* -5 kr_scale)))
	    (* 2 kr_scale)
	    "0"
	    (rtos kr_Ykk 2 3)
	 )
	 (command
	    "_text"
	    (list (+ kr_Ysk (* 1 kr_scale)) (+ kr_Xsk (* -2 kr_scale)))
	    (* 2 kr_scale)
	    "0"
	    (rtos kr_Xsk 2 3)
	 )
	 (command
	    "_text"
	    (list (+ kr_Ysk (* 1 kr_scale)) (+ kr_Xsk (* -5 kr_scale)))
	    (* 2 kr_scale)
	    "0"
	    (rtos kr_Ysk 2 3)
	 )
	 (if (/= kr_l 0)
	    (progn (command "_text"
			    (list (+ kr_NYpk (* 1 kr_scale)) (+ kr_NXpk (* -2 kr_scale)))
			    (* 2 kr_scale)
			    "0"
			    (rtos kr_NXpk 2 3)
		   )
		   (command "_text"
			    (list (+ kr_NYpk (* 1 kr_scale)) (+ kr_NXpk (* -5 kr_scale)))
			    (* 2 kr_scale)
			    "0"
			    (rtos kr_NYpk 2 3)
		   )
		   (command "_text"
			    (list (+ kr_KYpk (* 1 kr_scale)) (+ kr_KXpk (* -2 kr_scale)))
			    (* 2 kr_scale)
			    "0"
			    (rtos kr_KXpk 2 3)
		   )
		   (command "_text"
			    (list (+ kr_KYpk (* 1 kr_scale)) (+ kr_KXpk (* -5 kr_scale)))
			    (* 2 kr_scale)
			    "0"
			    (rtos kr_KYpk 2 3)
		   )
	    )
	 )
      )
   )
   (setvar "osmode" rumb_osmode)
   (exit)
)
;;;================================================================================================
;;;================================================================================================
;;;================================================================================================
;;;================================================================================================
;;;Программа сколки координат======================================================================
(defun C:SK ()
   (if (= sk_path nil)
      (setq sk_path "")
   )
   (if (= sk_name nil)
      (setq sk_name "skolka.dat")
   )
   (if (= rumb_scale_n nil)
      (setq rumb_scale_n "3")
   )
   (if (= sk_vnts nil)
      (setq sk_vnts "1")
   )
   (if (= sk_vline nil)
      (setq sk_vline "0")
   )
   (if (= sk_vcoor nil)
      (setq sk_vcoor "0")
   )
   (if (= sk_vcircle nil)
      (setq sk_vcircle "1")
   )
   (if (= sk_vfile nil)
      (setq sk_vfile "1")
   )
   (if (= sk_vh nil)
      (setq sk_vh "1")
   )
   (if (= sk_rb_coor nil)
      (setq sk_rb_coor "1")
   )
   (setq sk_p_nts "1")
   (setq sk_dcl (load_dialog "rumb.dcl"))
   (if (not (new_dialog "skolka" sk_dcl))
      (exit)
   )
   (setq rumb_lay_nam "Skolka")									    ;Определение слоя по умолчанию
   (rumb_pp_lay1)										    ;Подпрограмма определения слоя 1
   (set_tile "gp_vnts" sk_vnts)
   (set_tile "gp_vline" sk_vline)
   (set_tile "gp_vcoor" sk_vcoor)
   (set_tile "gp_vcircle" sk_vcircle)
   (set_tile "gp_vfile" sk_vfile)
   (set_tile "gp_vh" sk_vh)
   (set_tile "gp_scale" rumb_scale_n)
   (set_tile "gp_rad_circle" "0.2")
   (set_tile "gp_file_text" sk_name)
   (if (= sk_rb_coor "0")
      (set_tile "gp_rb_coorw" "1")
      (set_tile "gp_rb_coorg" "1")
   )
   (if (and (/= sk_vfile "0") (/= sk_vfile "1"))
      (mode_tile "gp_vh" 0)
      (mode_tile "gp_vh" 1)
   )
   (action_tile "gp_rb_coorw" "(setq sk_rb_coor \"0\")")					    ;Определение системы координат
   (action_tile "gp_rb_coorg" "(setq sk_rb_coor \"1\")")
   (action_tile											    ;Определение файла сколки
      "gp_vfile"
      (strcat
	 "(setq sk_vfile(get_tile \"gp_vfile\"))(if (= sk_vfile \"0\")"
	 "(progn(set_tile \"gp_file_text\" \"\")(mode_tile \"gp_file\" 1)(mode_tile \"gp_vh\" 1))"
	 "(progn(set_tile \"gp_file_text\" sk_name)(mode_tile \"gp_file\" 0)(mode_tile \"gp_vh\" 0)))"
;;;	 "(if (= sk_vfile \"1\")(mode_tile \"gp_vh\" 1)) для AutoCAD2000"
      )
   )
   (action_tile
      "gp_file"
      (strcat
	 "(setq sk_name (getfiled \"Выбор файла сколки\" sk_path \"dat\" 1))"
	 "(if sk_name (progn(setq sk_path (car (fnsplitl sk_name)))))"
	 "(set_tile \"gp_file_text\" sk_name)"
      )
   )
   (action_tile "gp_vnts" "(setq sk_vnts (get_tile \"gp_vnts\"))")				    ;Определение отрисовки названия
   (action_tile											    ;Определение отрисовки точки
      "gp_vcircle"
      (strcat "(setq sk_vcircle (get_tile \"gp_vcircle\"))"
	      "(if (= sk_vcircle \"1\")(mode_tile \"gp_rad_circle\" 0)(mode_tile \"gp_rad_circle\" 1))"
      )
   )
   (action_tile "gp_vcoor" "(setq sk_vcoor (get_tile \"gp_vcoor\"))")				    ;Определение отрисовки координат
   (action_tile "gp_vline" "(setq sk_vline (get_tile \"gp_vline\"))")				    ;Определение отрисовки линии
   (action_tile "gp_vh" "(setq sk_vh (get_tile \"gp_vh\"))")					    ;Определение отрисовки отметок
   (action_tile "cancel" "(done_dialog)(exit)")							    ;Определение кнопки "Нет"
   (action_tile											    ;Определение кнопки "Да"
      "accept"
      (strcat
	 "(setq rumb_scale_n (get_tile \"gp_scale\"))"
	 "(setq sk_rad_circle (atof (get_tile \"gp_rad_circle\")))"
	 "(done_dialog)"
      )
   )
   (start_dialog)
   (unload_dialog sk_dcl)
   (rumb_pp_lay2)										    ;Подпрограмма определения слоя 2
   (setq rumb_scale (rumb_pp_scale rumb_scale_n))
   (setq sk_op "2")
   (while (/= sk_ts 0)
      (setq sk_file (open sk_name "a"))
      (initget 7 "Новая")
      (if (or (= sk_pts nil) (= sk_op "2"))
	 (setq sk_ts (getpoint "\nНовая трасса/<Точка сколки>: "))
	 (setq sk_ts (getpoint sk_pts "\nНовая трасса/<Точка сколки>: "))
      )
      (if (= sk_ts "Новая")
	 (progn	(write-line "" sk_file)
		(write-line "OP" sk_file)
		(alert "Новая трасса\nопределена.")
		(setq sk_ts (getpoint "\n<Точка сколки>: "))
		(setq sk_op "2")
	 )
      )
      (setq rumb_osmode (getvar "osmode"))
      (setvar "osmode" 0)
      (if (= sk_vcircle "1")									    ; Отрисовка точки
	 (command "_circle" sk_ts (* sk_rad_circle rumb_scale))
      )
      (if (and (= sk_vline "1") (= sk_op "1"))							    ; Отрисовка линии
	 (command "_line" sk_ts sk_pts "")
      )
      (if (= sk_vcoor "1")									    ; Отрисовка координат
	 (progn
	    (command "_text"
		     (list (+ (* 3 rumb_scale) (car sk_ts)) (+ (* -5 rumb_scale) (cadr sk_ts)))
		     (* 2 rumb_scale)
		     "0"
		     (rtos (cadr sk_ts) 2 3)
	    )
	    (command "_text"
		     (list (+ (* 3 rumb_scale) (car sk_ts)) (+ (* -8 rumb_scale) (cadr sk_ts)))
		     (* 2 rumb_scale)
		     "0"
		     (rtos (car sk_ts) 2 3)
	    )
	    (command "_line"
		     sk_ts
;;;	       (list (+ (* 2 rumb_scale) (car sk_ts)) (+ (* -2 rumb_scale) (cadr sk_ts)))
;;;	       (list (+ (car sk_ts) (* rumb_scale (+ 2 (* 2 (strlen (rtos (car sk_ts) 2 3))))))
;;;		     (+ (* -2 rumb_scale) (cadr sk_ts))
;;;	       )
		     (list (+ (* 2 rumb_scale) (car sk_ts)) (+ (* -9 rumb_scale) (cadr sk_ts)))
		     (list (+ (car sk_ts) (* rumb_scale (+ 2 (* 2 (strlen (rtos (car sk_ts) 2 3))))))
			   (+ (* -9 rumb_scale) (cadr sk_ts))
		     )
;;;	       (list (+ (* 2 rumb_scale) (car sk_ts)) (+ (* -2 rumb_scale) (cadr sk_ts)))
		     ""
	    )
	 )
      )
      (if (or (= sk_vnts "1") (= sk_vfile "1"))							    ; Запрос названия
	 (setq sk_nts (getstring (strcat "\nНазвание точки: <" sk_p_nts ">")))
      )
      (if (= sk_nts "")
	 (setq sk_nts sk_p_nts)
      )
      (if (= sk_vnts "1")									    ; Отрисовка названия
	 (command "_text"
		  (list (+ (* 1 rumb_scale) (car sk_ts)) (+ (* 1 rumb_scale) (cadr sk_ts)))
		  (* 2 rumb_scale)
		  "0"
		  sk_nts
	 )
      )
      (setq sk_len_s 1)
      (while (and (= (distof (substr sk_nts sk_len_s)) nil) (/= sk_len_s (+ 1 (strlen sk_nts))))
	 (setq sk_len_s (+ 1 sk_len_s))
      )
      (setq sk_p_nts (strcat (substr sk_nts 1 (- sk_len_s 1)) (itoa (+ 1 (atoi (substr sk_nts sk_len_s))))))
      (if (or (= sk_vfile "2") (= sk_vfile "3") (= sk_vfile "4"))				    ; Запрос отметок
	 (progn
	    (setq sk_h1 (getstring (strcat "\nОтметка точки: ")))
	    (if	(= sk_vh "1")
	       (command	"_text"
			(list (+ (* 1 rumb_scale) (car sk_ts)) (- (cadr sk_ts) (* 2.5 rumb_scale)))
			(* 2 rumb_scale)
			"0"
			sk_h1
	       )
	    )
	 )
      )
      (if (or (= sk_vfile "3") (= sk_vfile "4"))
	 (progn
	    (setq sk_h2 (getstring (strcat "\n2-ая отметка точки: ")))
	    (if	(= sk_vh "1")
	       (command	"_text"
			(list (+ (* 1 rumb_scale) (car sk_ts)) (- (cadr sk_ts) (* 5 rumb_scale)))
			(* 2 rumb_scale)
			"0"
			sk_h2
	       )
	    )
	 )
      )
      (if (= sk_vfile "4")
	 (progn
	    (setq sk_h3 (getstring (strcat "\n3-я отметка точки: ")))
	    (if	(= sk_vh "1")
	       (command	"_text"
			(list (+ (* 1 rumb_scale) (car sk_ts)) (- (cadr sk_ts) (* 7.5 rumb_scale)))
			(* 2 rumb_scale)
			"0"
			sk_h3
	       )
	    )
	 )
      )
      (setvar "osmode" rumb_osmode)
      (if (or (= sk_vnts "1") (= sk_vfile "1"))							    ;Добавление пробелов к названию до 10 символов
	 (while	(/= (strlen sk_nts) 10)
	    (setq sk_nts (strcat sk_nts " "))
	 )
      )
      (if (= sk_rb_coor "1")									    ;Запись строки данных в файл для геодезической системы
	 (progn
	    (if	(= sk_vfile "1")
	       (write-line (strcat sk_nts (rtos (cadr sk_ts) 2 3) "   " (rtos (car sk_ts) 2 3)) sk_file)
	    )
	    (if	(= sk_vfile "2")
	       (write-line (strcat sk_nts (rtos (cadr sk_ts) 2 3) "   " (rtos (car sk_ts) 2 3) "   " sk_h1)
			   sk_file
	       )
	    )
	    (if	(= sk_vfile "3")
	       (write-line (strcat sk_nts (rtos (cadr sk_ts) 2 3) "   " (rtos (car sk_ts) 2 3) "   " sk_h1 "   " sk_h2)
			   sk_file
	       )
	    )
	    (if	(= sk_vfile "4")
	       (write-line (strcat sk_nts
				   (rtos (cadr sk_ts) 2 3)
				   "   "
				   (rtos (car sk_ts) 2 3)
				   "   "
				   sk_h1
				   "   "
				   sk_h2
				   "   "
				   sk_h3
			   )
			   sk_file
	       )
	    )
	 )
      )
      (if (= sk_rb_coor "0")									    ;Запись строки данных в файл для мировой системы
	 (progn
	    (if	(= sk_vfile "1")
	       (write-line (strcat sk_nts (rtos (car sk_ts) 2 3) "   " (rtos (cadr sk_ts) 2 3)) sk_file)
	    )
	    (if	(= sk_vfile "2")
	       (write-line (strcat sk_nts (rtos (car sk_ts) 2 3) "   " (rtos (cadr sk_ts) 2 3) "   " sk_h1)
			   sk_file
	       )
	    )
	    (if	(= sk_vfile "3")
	       (write-line (strcat sk_nts (rtos (car sk_ts) 2 3) "   " (rtos (cadr sk_ts) 2 3) "   " sk_h1 "   " sk_h2)
			   sk_file
	       )
	    )
	    (if	(= sk_vfile "4")
	       (write-line (strcat sk_nts
				   (rtos (car sk_ts) 2 3)
				   "   "
				   (rtos (cadr sk_ts) 2 3)
				   "   "
				   sk_h1
				   "   "
				   sk_h2
				   "   "
				   sk_h3
			   )
			   sk_file
	       )
	    )
	 )
      )
      (close sk_file)										    ;Закрытие файла данных
      (setq sk_op "1")
      (setq sk_pts sk_ts)
   )
)
;;;================================================================================================
;;;================================================================================================
;;;================================================================================================
;;;================================================================================================
;;;Программа отрисовки профиля=====================================================================
(defun C:PRF ()
   (if (= prf_otm1 nil)
      (setq prf_otm1 "1")
   )
   (if (= prf_otm2 nil)
      (setq prf_otm2 "1")
   )
   (if (= prf_otm3 nil)
      (setq prf_otm3 "1")
   )
   (if (= prf_sline1 nil)
      (setq prf_sline1 "1")
   )
   (if (= prf_sline2 nil)
      (setq prf_sline2 "0")
   )
   (if (= prf_sline3 nil)
      (setq prf_sline3 "0")
   )
   (if (= prf_ord1 nil)
      (setq prf_ord1 "1")
   )
   (if (= prf_ord2 nil)
      (setq prf_ord2 "0")
   )
   (if (= prf_ord3 nil)
      (setq prf_ord3 "0")
   )
   (if (= prf_tchk1 nil)
      (setq prf_tchk1 "0")
   )
   (if (= prf_tchk2 nil)
      (setq prf_tchk2 "1")
   )
   (if (= prf_tchk3 nil)
      (setq prf_tchk3 "1")
   )
   (if (= prf_ras nil)
      (setq prf_ras "1")
   )
   (if (= prf_namegv nil)
      (setq prf_namegv "1")
   )
   (if (= prf_ukl nil)
      (setq prf_ukl "0")
   )
   (if (= prf_uklr nil)
      (setq prf_uklr "0")
   )
   (if (= prf_up nil)
      (setq prf_up "0")
   )
   (if (= prf_upm nil)
      (setq prf_upm 1)
   )
   (if (= prf_ug nil)
      (setq prf_ug 0)
   )
   (if (= prf_ugt nil)
      (setq prf_ugt "1")
   )
   (if (= rumb_scale_n nil)
      (setq rumb_scale_n "3")
   )
   (if (= rumb_scale2_n nil)
      (setq rumb_scale2_n "4")
   )
   (if (= prf_labs nil)
      (setq prf_labs "0")
   )
   (if (= prf_color nil)
      (setq prf_color "0")
   )
   (if (= prf_path nil)
      (setq prf_path "")
   )
   (if (= prf_name nil)
      (setq prf_name "")
   )
   (if (= prf_angle nil)
      (setq prf_angle "0")
   )
   (if (= prf_anglemin nil)
      (setq prf_anglemin "0")
   )
   (setq prf_dcl (load_dialog "rumb.dcl"))
   (if (not (new_dialog "profil" prf_dcl))
      (exit)
   )
   (setq rumb_lay_nam "Profil")									    ;Определение слоя по умолчанию
   (rumb_pp_lay1)										    ;Подпрограмма определения слоя 1
   (set_tile "gp_prf_otm1" prf_otm1)
   (set_tile "gp_prf_otm2" prf_otm2)
   (set_tile "gp_prf_otm3" prf_otm3)
   (set_tile "gp_prf_sline1" prf_sline1)
   (set_tile "gp_prf_sline2" prf_sline2)
   (set_tile "gp_prf_sline3" prf_sline3)
   (set_tile "gp_prf_ord1" prf_ord1)
   (set_tile "gp_prf_ord2" prf_ord2)
   (set_tile "gp_prf_ord3" prf_ord3)
   (set_tile "gp_prf_tchk1" prf_tchk1)
   (set_tile "gp_prf_tchk2" prf_tchk2)
   (set_tile "gp_prf_tchk3" prf_tchk3)
   (set_tile "gp_prf_ras" prf_ras)
   (set_tile "gp_prf_namegv" prf_namegv)
   (set_tile "gp_prf_ukl" prf_ukl)
   (set_tile "gp_prf_uklr" prf_uklr)
   (set_tile "gp_prf_up" prf_up)
   (set_tile "gp_prf_upm" (rtos prf_upm 2 3))
   (set_tile "gp_prf_ug" (rtos prf_ug 2 3))
   (set_tile "gp_prf_ugt" prf_ugt)
   (set_tile "gp_scale" rumb_scale_n)
   (set_tile "gp_scale2" rumb_scale2_n)
   (set_tile "gp_prf_labs" prf_labs)
   (set_tile "gp_prf_color" prf_color)
   (set_tile "gp_file_text" prf_name)
   (set_tile "gp_prf_angle" prf_angle)
   (set_tile "gp_prf_anglemin" prf_anglemin)
   (mode_tile "gp_prf_uklr" 1)
   (action_tile											    ;Определение параметров профиля
      "gp_prf_otm1"
      "(setq prf_otm1 (get_tile \"gp_prf_otm1\"))"
   )
   (action_tile
      "gp_prf_otm2"
      "(setq prf_otm2 (get_tile \"gp_prf_otm2\"))"
   )
   (action_tile
      "gp_prf_otm3"
      "(setq prf_otm3 (get_tile \"gp_prf_otm3\"))"
   )
   (action_tile
      "gp_prf_sline1"
      "(setq prf_sline1 (get_tile \"gp_prf_sline1\"))"
   )
   (action_tile
      "gp_prf_sline2"
      "(setq prf_sline2 (get_tile \"gp_prf_sline2\"))"
   )
   (action_tile
      "gp_prf_sline3"
      "(setq prf_sline3 (get_tile \"gp_prf_sline3\"))"
   )
   (action_tile
      "gp_prf_ord1"
      "(setq prf_ord1 (get_tile \"gp_prf_ord1\"))"
   )
   (action_tile
      "gp_prf_ord2"
      "(setq prf_ord2 (get_tile \"gp_prf_ord2\"))"
   )
   (action_tile
      "gp_prf_ord3"
      "(setq prf_ord3 (get_tile \"gp_prf_ord3\"))"
   )
   (action_tile
      "gp_prf_tchk1"
      "(setq prf_tchk1 (get_tile \"gp_prf_tchk1\"))"
   )
   (action_tile
      "gp_prf_tchk2"
      "(setq prf_tchk2 (get_tile \"gp_prf_tchk2\"))"
   )
   (action_tile
      "gp_prf_tchk3"
      "(setq prf_tchk3 (get_tile \"gp_prf_tchk3\"))"
   )
   (action_tile
      "gp_prf_ras"
      "(setq prf_ras (get_tile \"gp_prf_ras\"))"
   )
   (action_tile
      "gp_prf_namegv"
      "(setq prf_namegv (get_tile \"gp_prf_namegv\"))"
   )
   (action_tile
      "gp_prf_ukl"
      (strcat
	 "(setq prf_ukl (get_tile \"gp_prf_ukl\"))"
	 "(if (= prf_ukl \"0\") (mode_tile \"gp_prf_uklr\" 1) (mode_tile \"gp_prf_uklr\" 0))"
      )
   )
   (action_tile
      "gp_prf_uklr"
      "(setq prf_uklr (get_tile \"gp_prf_uklr\"))"
   )
   (action_tile
      "gp_prf_up"
      "(setq prf_up (get_tile \"gp_prf_up\"))"
   )
   (action_tile
      "gp_prf_upm"
      "(setq prf_upm (get_tile \"gp_prf_upm\"))"
   )
   (action_tile
      "gp_prf_ug"
      "(setq prf_ug (atof (get_tile \"gp_prf_ug\")))"
   )
   (action_tile
      "gp_prf_ugt"
      "(setq prf_ugt (get_tile \"gp_prf_ugt\"))"
   )
   (action_tile
      "gp_prf_labs"
      "(setq prf_labs (get_tile \"gp_prf_labs\"))"
   )
   (action_tile
      "gp_prf_color"
      "(setq prf_color (get_tile \"gp_prf_color\"))"
   )
   (action_tile
      "gp_prf_angle"
      "(setq prf_angle (get_tile \"gp_prf_angle\"))"
   )
   (action_tile
      "gp_prf_anglemin"
      "(setq prf_anglemin (get_tile \"gp_prf_anglemin\"))"
   )
   (setq prf_vfile "1")										    ; Определение файла данных
   (action_tile
      "gp_file"
      (strcat
	 "(setq prf_name (getfiled \"Выбор файла данных\" prf_path \"dat\" 4))"
	 "(if prf_name (progn(setq prf_path (car (fnsplitl prf_name)))))"
	 "(set_tile \"gp_file_text\" prf_name)"
      )
   )
   (action_tile "cancel" "(done_dialog)(exit)")							    ;Определение кнопки "Нет"
   (action_tile											    ;Определение кнопки "Да"
      "accept"
      (strcat "(setq rumb_scale_n (get_tile \"gp_scale\"))"
	      "(setq rumb_scale2_n (get_tile \"gp_scale2\"))"
	      "(done_dialog)"
      )
   )
   (start_dialog)
   (unload_dialog prf_dcl)
;;;Установка масштабных коэффициентов
   (rumb_pp_lay2)										    ;Подпрограмма определения слоя 1
   (setq rumb_scale (rumb_pp_scale rumb_scale_n))
   (setq rumb_scale2 (* (rumb_pp_scale rumb_scale2_n) 0.1))
   (if (= prf_uklr "0")
      (setq prf_uklk 1)
   )
   (if (= prf_uklr "1")
      (setq prf_uklk 10)
   )
   (if (= prf_uklr "2")
      (setq prf_uklk 100)
   )
   (if (= prf_uklr "3")
      (setq prf_uklk 1000)
   )
;;;Открытие файла 
   (if (= prf_name "")
      (progn
	 (alert "Укажите файл данных")
	 (prf_end)
      )
   )
   (setq prf_file (open prf_name "r"))
   (setq prf_str (read-line prf_file))
   (if (/= (substr prf_str 1 3) "300")
      (progn
	 (alert "Указанный файл не является\nфайлом данных профиля")
	 (prf_end)
      )

   )
;;;начало считывания данных
   (setq prf_str (read-line prf_file))
   (while
      (and
	 (/= (substr prf_str 1 3) "prk")
	 (/= (substr prf_str 1 3) "PRK")
	 (/= (substr prf_str 1 3) "prr")
	 (/= (substr prf_str 1 3) "PRR")
	 (/= prf_str nil)
      )
	(setq prf_str (read-line prf_file))
	(setq prf_pd (substr prf_str 1 3))

	(if (= prf_str nil)
	   (progn
	      (alert "Файл не содержит данных по профилю")
	      (prf_end)
	   )
	)
   )
   (setq prf_n_otm (atof (substr prf_str 4 1)))
   (if (< 3 prf_n_otm)
      (progn
	 (alert "Колличество отметок в строке не больше трех")
	 (prf_end)
      )
   )
   (if (and (/= prf_n_otm 1) (/= prf_n_otm 2) (/= prf_n_otm 3))
      (progn
	 (alert "Колличество отметок в строке задано не правильно")
	 (prf_end)
      )
   )
;;;Ввод исходных данных
   (setq prf_line_ug (getpoint "\nУкажите точку в начале профиля на линии условного горизонта:"))
   (if (and (/= prf_otm1 "0") (= prf_n_otm 1))
      (progn (setq prf_line_h1 (getpoint "\nУкажите нижнюю точку графы отметки:"))
	     (setq prf_line_h1 (list (car prf_line_ug) (cadr prf_line_h1)))
      )
   )
   (if (< 1 prf_n_otm)
      (progn
	 (if (/= prf_otm1 "0")
	    (progn
	       (setq prf_line_h1 (getpoint "\nУкажите нижнюю точку 1-ой графы отметки:"))
	       (setq prf_line_h1 (list (car prf_line_ug) (cadr prf_line_h1)))
	    )
	 )
	 (if (/= prf_otm2 "0")
	    (progn
	       (setq prf_line_h2 (getpoint "\nУкажите нижнюю точку 2-ой графы отметки:"))
	       (setq prf_line_h2 (list (car prf_line_ug) (cadr prf_line_h2)))
	    )
	 )
	 (if (and (< 2 prf_n_otm) (/= prf_otm3 "0"))
	    (progn (setq prf_line_h3 (getpoint "\nУкажите нижнюю точку 3-ей графы отметки:"))
		   (setq prf_line_h3 (list (car prf_line_ug) (cadr prf_line_h3)))
	    )
	 )
      )
   )
   (if (= prf_ras "1")
      (progn (setq prf_line_dist (getpoint "\nУкажите нижнюю точку графы расстояния:"))
	     (setq prf_line_dist (list (car prf_line_ug) (cadr prf_line_dist)))
      )
   )
   (if (/= prf_namegv "0")
      (progn (setq prf_line_name (getpoint "\nУкажите нижнюю точку графы названия:"))
	     (setq prf_line_name (list (car prf_line_ug) (cadr prf_line_name)))
      )
   )
   (if (/= prf_ukl "0")
      (progn (setq prf_line_ukl (getpoint "\nУкажите нижнюю точку графы уклоны:"))
	     (setq prf_line_ukl (list (car prf_line_ug) (cadr prf_line_ukl)))
      )
   )
   (if (/= prf_angle "0")
      (progn (setq prf_line_angle (getpoint "\nУкажите нижнюю точку графы углы поворота"))
	     (setq prf_line_angle (list (car prf_line_ug) (cadr prf_line_angle)))
      )
   )
   (if (= prf_ugt "1")
      (command
	 "_text"
	 "_j"
	 "_r"
	 (list (- (car prf_line_ug) rumb_scale)
	       (+ (cadr prf_line_ug) rumb_scale)
	 )
	 (* 2 rumb_scale)
	 "0"
	 (if (=	0
		(- (atof (rtos prf_ug 2 2))
		   (atof (rtos prf_ug 2 0))
		)
	     )
	    (strcat "Условный горизонт " (rtos prf_ug 2 2) ".00")
	    (if	(= 0
		   (- (atof (rtos prf_ug 2 2))
		      (atof (rtos prf_ug 2 1))
		   )
		)
	       (strcat "Условный горизонт " (rtos prf_ug 2 2) "0")
	       (strcat "Условный горизонт " (rtos prf_ug 2 2))

	    )
	 )
      )
   )
   (if (= prf_labs "1")
      (progn
	 (setq prf_line_ug_n prf_line_ug)
	 (setq prf_line_h1_n prf_line_h1)
	 (setq prf_line_h2_n prf_line_h2)
	 (setq prf_line_h3_n prf_line_h3)
	 (setq prf_line_dist_n prf_line_dist)
	 (setq prf_line_name_n prf_line_name)
	 (setq prf_line_ukl_n prf_line_ukl)
	 (setq prf_line_angle_n prf_line_angle)

      )
   )
   (if (or (= prf_pd "prr") (= prf_pd "PRR"))
      (prf_r)
      (prf_k)
   )
)
;;;-----------------------------------------------------------------------
;;;Профиль по координатам-------------------------------------------------
(defun prf_k ()
   (setq prf_line_ugp1 nil)
   (setq prf_line_ugp2 nil)
   (setq prf_line_ugp3 nil)
   (setq prf_point_anglep 0)
   (prf_pp_readk)
   (prf_pp_name)										    ;Подписывание названия точки
   (setq prf_point_namep prf_point_name)
   (setq prf_Xp prf_X)
   (setq prf_Yp prf_Y)
   (prf_pp_otm prf_otm1 prf_line_h1 prf_point_h1)						    ;Подписывание отметки 1-го уровня
   (prf_pp_h prf_ord1 prf_point_h1 prf_sline1 prf_line_ugp1 prf_point_hp1 prf_tchk1)
   (setq prf_point_hp1 (atof prf_point_h1))
   (setq prf_line_ugp1 prf_line_ug)
   (if (> prf_n_otm 1)										    ;Подписывание отметки 2-го уровня
      (progn
	 (prf_pp_otm prf_otm2 prf_line_h2 prf_point_h2)
	 (prf_pp_h prf_ord2 prf_point_h2 prf_sline2 prf_line_ugp2 prf_point_hp2 prf_tchk2)
	 (setq prf_point_hp2 (atof prf_point_h2))
	 (setq prf_line_ugp2 prf_line_ug)
      )
   )
   (if (= prf_n_otm 3)										    ;Подписывание отметки 3-го уровня
      (progn
	 (prf_pp_otm prf_otm3 prf_line_h3 prf_point_h3)
	 (prf_pp_h prf_ord3 prf_point_h3 prf_sline3 prf_line_ugp3 prf_point_hp3 prf_tchk3)
	 (setq prf_point_hp3 (atof prf_point_h3))
	 (setq prf_line_ugp3 prf_line_ug)
      )
   )

;;;Начало цикла
   (while (or (/= prf_str nil) (/= prf_str "") (/= prf_str " "))
      (prf_pp_readk)
      (setq prf_point_dist (distance (list prf_Xp prf_Yp) (list prf_X prf_Y)))			    ;Вычисление расстояния
      (setq prf_point_angle (angle (list prf_Xp prf_Yp) (list prf_X prf_Y)))			    ;Вычисление угла
      (setq prf_Xp prf_X)
      (setq prf_Yp prf_Y)
      (setq prf_line_ug (list (+ (car prf_line_ug) prf_point_dist) (cadr prf_line_ug)))		    ;Вычисление линиии условного горизонта
      (if (/= prf_namegv "0")									    ;Графа названия точки
	 (setq prf_line_name (list (+ (car prf_line_name) prf_point_dist) (cadr prf_line_name)))
      )
      (prf_pp_name)
      (if (and (/= prf_point_dist 0) (= prf_ras "1"))						    ;Графа расстояния
	 (progn
	    (setq prf_line_dist (list (+ (car prf_line_dist) prf_point_dist) (cadr prf_line_dist)))
	    (prf_pp_dist)
	 )
      )
      (if (= prf_ukl "1")									    ;Графа уклоны
	 (prf_pp_ukl prf_point_h1 prf_point_hp1 prf_line_ugp1)
      )
      (if (= prf_ukl "2")
	 (prf_pp_ukl prf_point_h2 prf_point_hp2 prf_line_ugp2)
      )
      (if (= prf_ukl "3")
	 (prf_pp_ukl prf_point_h3 prf_point_hp3 prf_line_ugp3)
      )
      (if (/= prf_otm1 "0")									    ;Отметки 1-го уровня
	 (setq prf_line_h1 (list (+ (car prf_line_h1) prf_point_dist) (cadr prf_line_h1)))
      )
      (if (/= prf_point_h1 "0")
	 (progn
	    (prf_pp_otm prf_otm1 prf_line_h1 prf_point_h1)
	    (prf_pp_h prf_ord1 prf_point_h1 prf_sline1 prf_line_ugp1 prf_point_hp1 prf_tchk1)
	    (setq prf_point_hp1 (atof prf_point_h1))
	    (setq prf_line_ugp1 prf_line_ug)
	 )
      )
      (if (and (> prf_n_otm 1) (/= prf_otm2 "0"))						    ;Отметки 2-го уровня
	 (setq prf_line_h2 (list (+ (car prf_line_h2) prf_point_dist) (cadr prf_line_h2)))
      )
      (if (and (> prf_n_otm 1) (/= prf_point_h2 "0"))
	 (progn
	    (prf_pp_otm prf_otm2 prf_line_h2 prf_point_h2)
	    (if	(= prf_color "1")
	       (command "_color" "1")
	    )
	    (prf_pp_h prf_ord2 prf_point_h2 prf_sline2 prf_line_ugp2 prf_point_hp2 prf_tchk2)
	    (if	(= prf_color "1")
	       (command "_color" "7")
	    )
	    (setq prf_point_hp2 (atof prf_point_h2))
	    (setq prf_line_ugp2 prf_line_ug)
	 )
      )
      (if (and (= prf_n_otm 3) (/= prf_otm3 "0"))						    ;Отметки 3-го уровня
	 (setq prf_line_h3 (list (+ (car prf_line_h3) prf_point_dist) (cadr prf_line_h3)))
      )
      (if (and (= prf_n_otm 3) (/= prf_point_h3 "0"))
	 (progn
	    (prf_pp_otm prf_otm3 prf_line_h3 prf_point_h3)
	    (if	(= prf_color "1")
	       (command "_color" "3")
	    )
	    (prf_pp_h prf_ord3 prf_point_h3 prf_sline3 prf_line_ugp3 prf_point_hp3 prf_tchk3)
	    (if	(= prf_color "1")
	       (command "_color" "7")
	    )
	    (setq prf_point_hp3 (atof prf_point_h3))
	    (setq prf_line_ugp3 prf_line_ug)
	 )
      )
      (if (/= prf_angle "0")									    ;Углы поворота
	 (progn
	    (if	(= prf_point_anglep 0)
	       (command	"_line"
			(list (car prf_line_angle) (+ (cadr prf_line_angle) (* 5 rumb_scale)))
			(list (+ (car prf_line_angle) (- prf_point_dist (* 3 rumb_scale)))
			      (+ (cadr prf_line_angle) (* 5 rumb_scale))
			)
			""
	       )
	    )
	    (if	(/= prf_point_anglep 0)
	       (progn
		  (command "_text"
			   "_j"
			   "_c"
			   (if (< (- (+ prf_point_anglep pi) prf_point_angle) pi)
			      (list (car prf_line_angle) (+ (cadr prf_line_angle) rumb_scale))
			      (list (car prf_line_angle) (+ (cadr prf_line_angle) (* 7 rumb_scale)))
			   )
			   (* 2 rumb_scale)
			   "0"
			   (if (< (- (+ prf_point_anglep pi) prf_point_angle) pi)
			      (angtos (- (+ prf_point_anglep pi) prf_point_angle) 0 0)
			      (angtos (- (* 2 pi) (- (+ prf_point_anglep pi) prf_point_angle)) 0 0)
			   )
		  )
		  (command "_line"
			   (list (- (car prf_line_angle) (* 3 rumb_scale)) (+ (cadr prf_line_angle) (* 5 rumb_scale)))
			   (if (< (- (+ prf_point_anglep pi) prf_point_angle) pi)
			      (list (car prf_line_angle) (+ (cadr prf_line_angle) (* 9 rumb_scale)))
			      (list (car prf_line_angle) (+ (cadr prf_line_angle) rumb_scale))
			   )
			   (list (+ (car prf_line_angle) (* 3 rumb_scale)) (+ (cadr prf_line_angle) (* 5 rumb_scale)))
			   (list (+ (car prf_line_angle) (- prf_point_dist (* 3 rumb_scale)))
				 (+ (cadr prf_line_angle) (* 5 rumb_scale))
			   )
			   ""
		  )
	       )
	    )
	    (setq prf_point_anglep prf_point_angle)
	    (setq prf_line_angle (list (+ (car prf_line_angle) prf_point_dist) (cadr prf_line_angle)))
	 )
      )
   )
)
;;;-----------------------------------------------------------------------
;;;Профиль по расстояниям-------------------------------------------------
(defun prf_r ()
   (setq prf_str (read-line prf_file))
   (setq prf_point_dist 0)
   (setq prf_dist_ukl 0)
   (setq prf_line_ugp1 nil)
   (setq prf_line_ugp2 nil)
   (setq prf_line_ugp3 nil)
   (while (/= prf_str nil)									    ;Начало цикла
      (setq prf_len_s 1)
      (setq prf_sim "A")
;;;	Отрисовка названия точки
      (while (/= prf_sim " ")
	 (setq prf_len_s (+ 1 prf_len_s))
	 (setq prf_sim (substr prf_str prf_len_s 1))
      )
      (setq prf_point_name (substr prf_str 1 (- prf_len_s 1)))
      (prf_pp_name)
;;;	Пробел перед отметкой 1-го уровня
      (while (= prf_sim " ")
	 (setq prf_len_s (+ 1 prf_len_s))
	 (setq prf_sim (substr prf_str prf_len_s 1))
      )
      (setq prf_sim_s prf_len_s)
;;;	Отрисовка отметки 1-уровня
      (while (/= prf_sim " ")
	 (setq prf_len_s (+ 1 prf_len_s))
	 (setq prf_sim (substr prf_str prf_len_s 1))
      )
      (if (and (/= prf_point_h1 nil) (/= prf_point_h1 "0"))
	 (setq prf_point_hp1 (atof prf_point_h1))
      )
      (setq prf_point_h1 (substr prf_str prf_sim_s (- prf_len_s prf_sim_s)))
      (if (/= prf_point_h1 "0")
	 (progn
	    (prf_pp_otm prf_otm1 prf_line_h1 prf_point_h1)
	    (prf_pp_h prf_ord1 prf_point_h1 prf_sline1 prf_line_ugp1 prf_point_hp1 prf_tchk1)
	 )
      )
;;;	Пробел перед отметкой 2-го уровня
      (if (> prf_n_otm 1)
	 (progn
	    (while (= prf_sim " ")
	       (setq prf_len_s (+ 1 prf_len_s))
	       (setq prf_sim (substr prf_str prf_len_s 1))
	    )
	    (setq prf_sim_s prf_len_s)
;;;	Отрисовка отметки 2-уровня
	    (while (/= prf_sim " ")
	       (setq prf_len_s (+ 1 prf_len_s))
	       (setq prf_sim (substr prf_str prf_len_s 1))
	    )
	    (if	(and (/= prf_point_h2 nil) (/= prf_point_h2 "0"))
	       (setq prf_point_hp2 (atof prf_point_h2))
	    )
	    (setq prf_point_h2 (substr prf_str prf_sim_s (- prf_len_s prf_sim_s)))
	    (if	(/= prf_point_h2 "0")
	       (progn
		  (prf_pp_otm prf_otm2 prf_line_h2 prf_point_h2)
		  (if (= prf_color "1")
		     (command "_color" "1")
		  )
		  (prf_pp_h prf_ord2 prf_point_h2 prf_sline2 prf_line_ugp2 prf_point_hp2 prf_tchk2)
		  (if (= prf_color "1")
		     (command "_color" "7")
		  )

	       )
	    )
	 )
      )
;;;	Пробел перед отметкой 3-го уровня
      (if (> prf_n_otm 2)
	 (progn
	    (while (= prf_sim " ")
	       (setq prf_len_s (+ 1 prf_len_s))
	       (setq prf_sim (substr prf_str prf_len_s 1))
	    )
	    (setq prf_sim_s prf_len_s)
;;;	Отрисовка отметки 3-уровня
	    (while (/= prf_sim " ")
	       (setq prf_len_s (+ 1 prf_len_s))
	       (setq prf_sim (substr prf_str prf_len_s 1))
	    )
	    (if	(and (/= prf_point_h3 nil) (/= prf_point_h3 "0"))
	       (setq prf_point_hp3 (atof prf_point_h3))
	    )
	    (setq prf_point_h3 (substr prf_str prf_sim_s (- prf_len_s prf_sim_s)))
	    (if	(/= prf_point_h3 "0")
	       (progn
		  (prf_pp_otm prf_otm3 prf_line_h3 prf_point_h3)
		  (if (= prf_color "1")
		     (command "_color" "3")
		  )
		  (prf_pp_h prf_ord3 prf_point_h3 prf_sline3 prf_line_ugp3 prf_point_hp3 prf_tchk3)
		  (if (= prf_color "1")
		     (command "_color" "7")
		  )

	       )
	    )
	 )
      )
;;;	Отрисовка уклона
      (if (and (= prf_ukl "1") (/= prf_line_ugp1 nil))
	 (prf_pp_ukl prf_point_h1 prf_point_hp1 prf_line_ugp1)
      )
      (if (and (= prf_ukl "2") (/= prf_line_ugp2 nil))
	 (prf_pp_ukl prf_point_h2 prf_point_hp2 prf_line_ugp2)
      )
      (if (and (= prf_ukl "3") (/= prf_line_ugp3 nil))
	 (prf_pp_ukl prf_point_h3 prf_point_hp3 prf_line_ugp3)
      )
;;;	Отрисовка расстояния
      (if (and (/= prf_point_dist 0) (= prf_ras "1"))
	 (prf_pp_dist)
      )
;;;	Расстояние до следующей точки
      (while (= prf_sim " ")
	 (setq prf_len_s (+ 1 prf_len_s))
	 (setq prf_sim (substr prf_str prf_len_s 1))
      )
      (setq prf_point_dist (atof (substr prf_str prf_len_s)))
      (if (= prf_point_dist 0)
	 (prf_end)
      )
      (if (/= prf_point_h1 "0")
	 (setq prf_line_ugp1 prf_line_ug)
      )
      (if (/= prf_point_h2 "0")
	 (setq prf_line_ugp2 prf_line_ug)
      )
      (if (/= prf_point_h3 "0")
	 (setq prf_line_ugp3 prf_line_ug)
      )
      (setq prf_line_ug
	      (list (+ (car prf_line_ug) prf_point_dist)
		    (cadr prf_line_ug)
	      )
      )
      (if (/= prf_otm1 "0")
	 (setq prf_line_h1
		 (list (+ (car prf_line_h1) prf_point_dist)
		       (cadr prf_line_h1)
		 )
	 )
      )
      (if (and (> prf_n_otm 1) (/= prf_otm2 "0"))
	 (setq prf_line_h2
		 (list (+ (car prf_line_h2) prf_point_dist)
		       (cadr prf_line_h2)
		 )
	 )
      )
      (if (and (> prf_n_otm 2) (/= prf_otm3 "0"))
	 (setq prf_line_h3
		 (list (+ (car prf_line_h3) prf_point_dist)
		       (cadr prf_line_h3)
		 )
	 )
      )
      (if (= prf_ras "1")
	 (setq prf_line_dist
		 (list (+ (car prf_line_dist) prf_point_dist)
		       (cadr prf_line_dist)
		 )
	 )
      )
      (if (/= prf_namegv "0")
	 (setq prf_line_name
		 (list (+ (car prf_line_name) prf_point_dist)
		       (cadr prf_line_name)
		 )
	 )
      )
      (setq prf_str (read-line prf_file))
   )
   (close prf_file)
   (prf_end)
)
;;;-----------------------------------------------------------------------
;;;Отрисовка шапки, конец программы---------------------------------------
(defun prf_end ()
   (if (= prf_labs "1")
      (progn
	 (command
	    "_line"
	    prf_line_ug_n
	    prf_line_ug
	    ""
	 )
	 (command
	    "_line"
	    prf_line_h1_n
	    prf_line_h1
	    ""
	 )
	 (command
	    "_line"
	    prf_line_h2_n
	    prf_line_h2
	    ""
	 )
	 (command
	    "_line"
	    prf_line_h3_n
	    prf_line_h3
	    ""
	 )
	 (command
	    "_line"
	    prf_line_dist_n
	    prf_line_dist
	    ""
	 )
	 (command
	    "_line"
	    prf_line_name_n
	    prf_line_name
	    ""
	 )
	 (command
	    "_line"
	    prf_line_ukl_n
	    prf_line_ukl
	    ""
	 )
	 (command
	    "_line"
	    prf_line_angle_n
	    prf_line_angle
	    ""
	 )
      )
   )
   (close prf_file)
   (exit)
)
;;;-----------------------------------------------------------------------
;;;Подпрограмма подписывания названия точки-------------------------------
(defun prf_pp_name ()
   (if (/= prf_namegv "0")
      (command "_text"
	       "_j"
	       (if (= prf_namegv "1")
		  "_c"
		  "_ml"
	       )
	       (list (car prf_line_name)
		     (+ (cadr prf_line_name) rumb_scale)
	       )
	       (* 2 rumb_scale)
	       (if (= prf_namegv "1")
		  0
		  90
	       )
	       prf_point_name
      )
   )
)
;;;-----------------------------------------------------------------------
;;;Подпрограмма подписывания отметки точки-------------------------------
(defun prf_pp_otm (prf_otm prf_line_h prf_point_h)
   (if (/= prf_otm "0")
      (progn
	 (command
	    "_text"
	    (if	(= prf_otm "1")
	       (list (+ (car prf_line_h) rumb_scale) (+ (cadr prf_line_h) rumb_scale))
	       (list (- (car prf_line_h) rumb_scale) (+ (cadr prf_line_h) rumb_scale))
	    )
	    (* 2 rumb_scale)
	    "90"
	    (if	(= 0
		   (- (atof (rtos (atof prf_point_h) 2 2))
		      (atof (rtos (atof prf_point_h) 2 0))
		   )
		)
	       (strcat (rtos (atof prf_point_h) 2 2) ".00")
	       (if (= 0
		      (- (atof (rtos (atof prf_point_h) 2 2))
			 (atof (rtos (atof prf_point_h) 2 1))
		      )
		   )
		  (strcat (rtos (atof prf_point_h) 2 2) "0")
		  (rtos (atof prf_point_h) 2 2)
	       )
	    )
	 )
	 (if (= prf_otm "2")
	    (command "_line"
		     prf_line_h
		     (list (car prf_line_h) (+ (cadr prf_line_h) (* rumb_scale 15)))
		     ""
	    )
	 )
      )
   )
)
;;;-----------------------------------------------------------------------
;;;Подпрограмма вычерчивания ординаты, соед. линии и точки----------------
(defun prf_pp_h	(prf_ord prf_point_h prf_sline prf_line_ugp prf_point_hp prf_tchk)
   (if (= prf_ord "1")										    ;Вычерчивание ординаты
      (command "_line"
	       prf_line_ug
	       (list (car prf_line_ug)
		     (+	(cadr prf_line_ug)
			(* (- (atof prf_point_h) prf_ug) (/ rumb_scale rumb_scale2))
		     )
	       )
	       ""
      )
   )
   (if (and (= prf_sline "1") (/= prf_line_ugp nil))						    ;Вычерчивание соединительной линии
      (command "_line"
	       (list (car prf_line_ugp)
		     (+	(cadr prf_line_ugp)
			(* (- prf_point_hp prf_ug) (/ rumb_scale rumb_scale2))
		     )
	       )
	       (list (car prf_line_ug)
		     (+	(cadr prf_line_ug)
			(* (- (atof prf_point_h) prf_ug) (/ rumb_scale rumb_scale2))
		     )
	       )
	       ""
      )
   )
   (if (= prf_tchk "1")										    ;Вычерчивание точки
      (command "_circle"
	       (list (car prf_line_ug)
		     (+	(cadr prf_line_ug)
			(* (- (atof prf_point_h) prf_ug) (/ rumb_scale rumb_scale2))
		     )
	       )
	       (* 0.1 rumb_scale)
      )
   )
)
;;;-----------------------------------------------------------------------
;;;Подпрограмма вычерчивания графы расстояния-----------------------------
(defun prf_pp_dist ()
   (command
      "_line"
      prf_line_dist
      (list (car prf_line_dist)
	    (+ (cadr prf_line_dist)
	       (* 10 rumb_scale)
	    )
      )
      ""
   )
   (command
      "_text"
      "_j"
      "_c"
      (list (- (car prf_line_dist)
	       (/ prf_point_dist 2)
	    )
	    (+ (cadr prf_line_dist) rumb_scale)
      )
      (* 2 rumb_scale)
      "0"
      (if (= 0
	     (-	(atof (rtos prf_point_dist 2 2))
		(atof (rtos prf_point_dist 2 0))
	     )
	  )
	 (strcat (rtos prf_point_dist 2 2)
		 ".00"
	 )
	 (if (=	0
		(- (atof (rtos prf_point_dist 2 2))
		   (atof (rtos prf_point_dist 2 1))
		)
	     )
	    (strcat (rtos prf_point_dist 2 2)
		    "0"
	    )
	    (rtos prf_point_dist 2 2)
	 )
      )
   )
)
;;;-----------------------------------------------------------------------
;;;Подпрограмма вычерчивания графы уклоны и расстояния--------------------
(defun prf_pp_ukl (prf_point_h prf_point_hp prf_line_ugp)
   (setq prf_dist_ukl (- (car prf_line_ug) (car prf_line_ugp)))
   (if (and (/= prf_point_h "0") (/= prf_point_dist 0))
      (progn
	 (command
	    "_line"
	    (if	(= prf_point_hp (atof prf_point_h))
	       (list (car prf_line_ukl) (+ (cadr prf_line_ukl) (* 5 rumb_scale)))
	       (if (> prf_point_hp (atof prf_point_h))
		  (list (car prf_line_ukl) (+ (cadr prf_line_ukl) (* 10 rumb_scale)))
		  prf_line_ukl
	       )
	    )
	    (if	(= prf_point_hp (atof prf_point_h))
	       (list (+ (car prf_line_ukl) prf_dist_ukl) (+ (cadr prf_line_ukl) (* 5 rumb_scale)))
	       (if (> prf_point_hp (atof prf_point_h))
		  (list (+ (car prf_line_ukl) prf_dist_ukl) (cadr prf_line_ukl))
		  (list (+ (car prf_line_ukl) prf_dist_ukl) (+ (cadr prf_line_ukl) (* 10 rumb_scale)))
	       )
	    )
	    ""
	 )
	 (command
	    "_line"
	    prf_line_ukl
	    (list (car prf_line_ukl) (+ (cadr prf_line_ukl) (* 10 rumb_scale)))
	    ""
	 )
	 (command
	    "_text"
	    "_j"
	    (if	(= prf_point_hp (atof prf_point_h))
	       "_c"
	       (if (> prf_point_hp (atof prf_point_h))
		  "_br"
		  "_bl"
	       )
	    )
	    (list (+ (car prf_line_ukl) (/ prf_dist_ukl 2)) (+ (cadr prf_line_ukl) rumb_scale))
	    (* 1.8 rumb_scale)
	    "0"
	    (if	(= 0 (- (atof (rtos prf_dist_ukl 2 2)) (atof (rtos prf_dist_ukl 2 0))))
	       (strcat (rtos prf_dist_ukl 2 2) ".00")
	       (if (= 0 (- (atof (rtos prf_dist_ukl 2 2)) (atof (rtos prf_dist_ukl 2 1))))
		  (strcat (rtos prf_dist_ukl 2 2) "0")
		  (rtos prf_dist_ukl 2 2)
	       )
	    )
	 )
	 (command
	    "_text"
	    "_j"
	    (if	(= prf_point_hp (atof prf_point_h))
	       "_c"
	       (if (> prf_point_hp (atof prf_point_h))
		  "_bl"
		  "_br"
	       )
	    )
	    (list (+ (car prf_line_ukl) (/ prf_dist_ukl 2)) (+ (cadr prf_line_ukl) (* 6 rumb_scale)))
	    (* 1.8 rumb_scale)
	    "0"
	    (rtos
	       (abs (* (/ (- prf_point_hp (atof prf_point_h)) prf_dist_ukl) prf_uklk))
	       2
	       (if (= prf_uklk 1)
		  3
		  (if (= prf_uklk 10)
		     2
		     (if (= prf_uklk 100)
			1
			0
		     )
		  )
	       )
	    )
	 )
	 (setq prf_line_ukl (list (+ (car prf_line_ukl) prf_dist_ukl) (cadr prf_line_ukl)))
      )
   )
)
;;;-----------------------------------------------------------------------
;;;Подпрограмма считывания данных по координатам--------------------------
(defun prf_pp_readk ()
   (setq prf_str (read-line prf_file))

   (if (or (= prf_str nil) (= prf_str "") (= prf_str " "))
      (prf_end)
   )
   (setq prf_len_s 1)
   (setq prf_sim "A")
   (while (/= prf_sim " ")									    ;	Считывание названия точки
      (setq prf_len_s (+ 1 prf_len_s))
      (setq prf_sim (substr prf_str prf_len_s 1))
   )
   (setq prf_point_name (substr prf_str 1 (- prf_len_s 1)))
   (while (= prf_sim " ")									    ;	Пробел перед координатой Х
      (setq prf_len_s (+ 1 prf_len_s))
      (setq prf_sim (substr prf_str prf_len_s 1))
   )
   (setq prf_sim_s prf_len_s)
   (while (/= prf_sim " ")									    ;	Считывание координаты Х
      (setq prf_len_s (+ 1 prf_len_s))
      (setq prf_sim (substr prf_str prf_len_s 1))
   )
   (setq prf_X (atof (substr prf_str prf_sim_s (- prf_len_s prf_sim_s))))
   (while (= prf_sim " ")									    ;	Пробел перед координатой У
      (setq prf_len_s (+ 1 prf_len_s))
      (setq prf_sim (substr prf_str prf_len_s 1))
   )
   (setq prf_sim_s prf_len_s)
   (while (/= prf_sim " ")									    ;	Считывание координаты У
      (setq prf_len_s (+ 1 prf_len_s))
      (setq prf_sim (substr prf_str prf_len_s 1))
   )
   (setq prf_Y (atof (substr prf_str prf_sim_s (- prf_len_s prf_sim_s))))
   (while (= prf_sim " ")									    ;	Пробел перед отметкой 1-го уровня
      (setq prf_len_s (+ 1 prf_len_s))
      (setq prf_sim (substr prf_str prf_len_s 1))
   )
   (setq prf_sim_s prf_len_s)
   (if (= prf_n_otm 1)										    ;	Считывание отметки 1-уровня
      (setq prf_point_h1 (substr prf_str prf_len_s))
      (progn
	 (while	(/= prf_sim " ")
	    (setq prf_len_s (+ 1 prf_len_s))
	    (setq prf_sim (substr prf_str prf_len_s 1))
	 )
	 (setq prf_point_h1 (substr prf_str prf_sim_s (- prf_len_s prf_sim_s)))
	 (while	(= prf_sim " ")									    ;	Пробел перед отметкой 2-го уровня
	    (setq prf_len_s (+ 1 prf_len_s))
	    (setq prf_sim (substr prf_str prf_len_s 1))
	 )
	 (setq prf_sim_s prf_len_s)
	 (if (= prf_n_otm 2)									    ;	Считывание отметки 2-уровня
	    (setq prf_point_h2 (substr prf_str prf_len_s))
	    (progn
	       (while (/= prf_sim " ")
		  (setq prf_len_s (+ 1 prf_len_s))
		  (setq prf_sim (substr prf_str prf_len_s 1))
	       )
	       (setq prf_point_h2 (substr prf_str prf_sim_s (- prf_len_s prf_sim_s)))
	       (while (= prf_sim " ")								    ;	Пробел перед отметкой 3-го уровня
		  (setq prf_len_s (+ 1 prf_len_s))
		  (setq prf_sim (substr prf_str prf_len_s 1))
	       )
	       (setq prf_sim_s prf_len_s)
	       (setq prf_point_h3 (substr prf_str prf_len_s))					    ;	Считывание отметки 3-уровня
	    )
	 )
      )
   )												    ;	Конец считывания
)
;;;================================================================================================
;;;================================================================================================
;;;================================================================================================
;;;================================================================================================
;;;================================================================================================
;;;Программа отрисовки откосов=====================================================================
(defun C:OTK ()
   (if (= rumb_scale_n nil)
      (setq rumb_scale_n "3")
   )
   (setq otk_dcl (load_dialog "rumb.dcl"))
   (if (not (new_dialog "otkos" otk_dcl))
      (exit)
   )
   (set_tile "gp_scale" rumb_scale_n)
   (action_tile "cancel" "(done_dialog)(exit)")
   (action_tile
      "accept"
      (strcat "(setq rumb_scale_n (get_tile \"gp_scale\"))"
	      "(done_dialog)"
      )
   )
   (start_dialog)
   (unload_dialog otk_dcl)
   (setq rumb_scale (rumb_pp_scale rumb_scale_n))
   (setq rumb_osmode (getvar "osmode"))
   (setvar "osmode" 0)
   (command "_insert" "rumb_otk" (list 0 0) rumb_scale "" "0")
   (command "_line" (list 0 0) (list 0 (* rumb_scale -2)) "")
   (command "_zoom" "_c" (list 0 0) 10)
   (command "_block"
	    "rumb_otk"
	    "_y"
	    (list 0 0)
	    (ssget (list 0 0))
	    ""
   )
   (COMMAND "_erase" (ssget (list 0 0)) "")
   (command "_zoom" "_P")
   (setq V_otk (entsel "\nВыберите полилинию верха откоса:"))
   (setq N_otk (entsel "\nВыберите полилинию низа откоса:"))
   (command "_measure" V_otk "_b" "rumb_otk" "_y" rumb_scale)
   (setq bg_otk (ssget "X" '((2 . "rumb_otk"))))
   (setq bg_l_otk (sslength bg_otk))
   (setq bg_s_otk 0)
   (while (< bg_s_otk bg_l_otk)
      (command "_explode" (ssname bg_otk bg_s_otk))
      (setq point_bg_otk (cdr (assoc 11 (entget (entlast)))))
      (command "_zoom" "_c" point_bg_otk 1)
      (command "_extend" N_otk "" point_bg_otk "")
      (command "_zoom" "_P")
      (setq bg_s_otk (1+ bg_s_otk))
      (command "_explode" (ssname bg_otk bg_s_otk))
      (setq point_bg_otk (cdr (assoc 11 (entget (entlast)))))
      (setq bg_s_otk (1+ bg_s_otk))
   )
   (setvar "osmode" rumb_osmode)
   (princ)
   (exit)
)
;;;================================================================================================
;;;================================================================================================
;;;================================================================================================
;;;================================================================================================
;;;Программа вставки штампа, условных знаков и примечаний=========================================
(defun C:SHP ()
   (if (= sh_shtamp nil)
      (setq sh_shtamp "1")
   )
   (if (= sh_zakaz nil)
      (setq sh_zakaz "")
   )
   (if (= sh_kod nil)
      (setq sh_kod "")
   )
   (if (= sh_ob1 nil)
      (setq sh_ob1 "")
   )
   (if (= sh_ob2 nil)
      (setq sh_ob2 "")
   )
   (if (= sh_vid1 nil)
      (setq sh_vid1 "")
   )
   (if (= sh_vid2 nil)
      (setq sh_vid2 "")
   )
   (if (= sh_list nil)
      (setq sh_list "1")
   )
   (if (= sh_lists nil)
      (setq sh_lists "1")
   )
   (if (= sh_fio2 nil)
      (setq sh_fio2 "0")
   )
   (if (= sh_fio3 nil)
      (setq sh_fio3 "0")
   )
   (if (= sh_fio4 nil)
      (setq sh_fio4 "0")
   )
   (if (= sh_vid nil)
      (setq sh_vid "0")
   )
   (if (= rumb_scale_n nil)
      (setq rumb_scale_n "3")
   )
   (if (= sh_uszn nil)
      (setq sh_uszn "0")
   )
   (if (= sh_usdr nil)
      (setq sh_usdr "1")
   )
   (if (= sh_usvs nil)
      (setq sh_usvs "1")
   )
   (if (= sh_usvp nil)
      (setq sh_usvp "1")
   )
   (if (= sh_uskn nil)
      (setq sh_uskn "1")
   )
   (if (= sh_usgz nil)
      (setq sh_usgz "1")
   )
   (if (= sh_ustp nil)
      (setq sh_ustp "1")
   )
   (if (= sh_usek nil)
      (setq sh_usek "1")
   )
   (if (= sh_usks nil)
      (setq sh_usks "1")
   )
   (if (= sh_uspo nil)
      (setq sh_uspo "1")
   )
   (if (= sh_usgd nil)
      (setq sh_usgd "1")
   )
   (if (= sh_prim nil)
      (setq sh_prim "0")
   )
   (if (= sh_pr1 nil)
      (setq sh_pr1 "1")
   )
   (if (= sh_pr2 nil)
      (setq sh_pr2 "1")
   )
   (if (= sh_pr3 nil)
      (setq sh_pr3 "1")
   )
   (if (= sh_pr4 nil)
      (setq sh_pr4 "1")
   )
   (if (= sh_pr5 nil)
      (setq sh_pr5 "1")
   )
   (if (= sh_pr6 nil)
      (setq sh_pr6 "1")
   )
   (if (= sh_prt1 nil)
      (setq sh_prt1
	      "План составлен по материалам полевых работ проведенных кооперативом РУМБ 01.01.99"
      )
   )
   (if (= sh_prt2 nil)
      (setq sh_prt2 "Система координат городская")
   )
   (if (= sh_prt3 nil)
      (setq sh_prt3 "Система высот Балтийская")
   )
   (if (= sh_prt4 nil)
      (setq sh_prt4
	      "Измерения углов производилось теодолитом Theo-020B N315666"
      )
   )
   (if (= sh_prt5 nil)
      (setq sh_prt5
	      "Измерения длин линий производились светодальномером REDMINI-3 (SOKKIA) и стальной мерной лентой."
      )
   )
   (if (= sh_prt6 nil)
      (setq sh_prt6
	      "Уравнивание сети производилось параметрическим способом, методом наименьших квадратов, по программе RGS Сафонова А.С. (МИИГАиК - РУМБ)."
      )
   )
   (setq sh_dcl (load_dialog "rumb.dcl"))
   (if (not (new_dialog "shtamp" sh_dcl))
      (exit)
   )
   (set_tile "gp_shtamp" sh_shtamp)
   (set_tile "gp_zakaz" sh_zakaz)
   (set_tile "gp_kod" sh_kod)
   (set_tile "gp_ob1" sh_ob1)
   (set_tile "gp_ob2" sh_ob2)
   (set_tile "gp_vid1" sh_vid1)
   (set_tile "gp_vid2" sh_vid2)
   (set_tile "gp_list" sh_list)
   (set_tile "gp_lists" sh_lists)
   (set_tile "gp_fio2" sh_fio2)
   (set_tile "gp_fio3" sh_fio3)
   (set_tile "gp_fio4" sh_fio4)
   (set_tile "gp_vid" sh_vid)
   (set_tile "gp_scale" rumb_scale_n)
   (set_tile "gp_uszn" sh_uszn)
   (set_tile "gp_usdr" sh_usdr)
   (set_tile "gp_usvs" sh_usvs)
   (set_tile "gp_usvp" sh_usvp)
   (set_tile "gp_uskn" sh_uskn)
   (set_tile "gp_usgz" sh_usgz)
   (set_tile "gp_ustp" sh_ustp)
   (set_tile "gp_usek" sh_usek)
   (set_tile "gp_usks" sh_usks)
   (set_tile "gp_uspo" sh_uspo)
   (set_tile "gp_usgd" sh_usgd)
   (set_tile "gp_prim" sh_prim)
   (set_tile "gp_pr1" sh_pr1)
   (set_tile "gp_pr2" sh_pr2)
   (set_tile "gp_pr3" sh_pr3)
   (set_tile "gp_pr4" sh_pr4)
   (set_tile "gp_pr5" sh_pr5)
   (set_tile "gp_pr6" sh_pr6)
   (set_tile "gp_prt1" sh_prt1)
   (set_tile "gp_prt2" sh_prt2)
   (set_tile "gp_prt3" sh_prt3)
   (set_tile "gp_prt4" sh_prt4)
   (set_tile "gp_prt5" sh_prt5)
   (set_tile "gp_prt6" sh_prt6)
   (action_tile
      "gp_shtamp"
      "(setq sh_shtamp (get_tile \"gp_shtamp\"))"
   )
   (action_tile "gp_vntk_off" "(setq kr_vntk \"2\")")
   (action_tile
      "gp_zakaz"
      "(setq sh_zakaz (get_tile \"gp_zakaz\"))"
   )
   (action_tile "gp_kod" "(setq sh_kod (get_tile \"gp_kod\"))")
   (action_tile "gp_ob1" "(setq sh_ob1 (get_tile \"gp_ob1\"))")
   (action_tile "gp_ob2" "(setq sh_ob2 (get_tile \"gp_ob2\"))")
   (action_tile
      "gp_vid1"
      "(setq sh_vid1 (get_tile \"gp_vid1\"))"
   )
   (action_tile
      "gp_vid2"
      "(setq sh_vid2 (get_tile \"gp_vid2\"))"
   )
   (action_tile
      "gp_list"
      "(setq sh_list (get_tile \"gp_list\"))"
   )
   (action_tile
      "gp_lists"
      "(setq sh_lists (get_tile \"gp_lists\"))"
   )
   (action_tile
      "gp_uszn"
      "(setq sh_uszn (get_tile \"gp_uszn\"))"
   )
   (action_tile
      "gp_usdr"
      "(setq sh_usdr (get_tile \"gp_usdr\"))"
   )
   (action_tile
      "gp_usvs"
      "(setq sh_usvs (get_tile \"gp_usvs\"))"
   )
   (action_tile
      "gp_usvp"
      "(setq sh_usvp (get_tile \"gp_usvp\"))"
   )
   (action_tile
      "gp_uskn"
      "(setq sh_uskn (get_tile \"gp_uskn\"))"
   )
   (action_tile
      "gp_usgz"
      "(setq sh_usgz (get_tile \"gp_usgz\"))"
   )
   (action_tile
      "gp_ustp"
      "(setq sh_ustp (get_tile \"gp_ustp\"))"
   )
   (action_tile
      "gp_usek"
      "(setq sh_usek (get_tile \"gp_usek\"))"
   )
   (action_tile
      "gp_usks"
      "(setq sh_usks (get_tile \"gp_usks\"))"
   )
   (action_tile
      "gp_uspo"
      "(setq sh_uspo (get_tile \"gp_uspo\"))"
   )
   (action_tile
      "gp_usgd"
      "(setq sh_usgd (get_tile \"gp_usgd\"))"
   )
   (action_tile
      "gp_prim"
      (strcat
	 "(setq sh_prim (get_tile \"gp_prim\"))" "(setq sh_prt1 (get_tile \"gp_prt1\"))" "(setq sh_prt2 (get_tile \"gp_prt2\"))"
	 "(setq sh_prt3 (get_tile \"gp_prt3\"))" "(setq sh_prt4 (get_tile \"gp_prt4\"))" "(setq sh_prt5 (get_tile \"gp_prt5\"))"
	 "(setq sh_prt6 (get_tile \"gp_prt6\"))"
	)
   )
   (action_tile "gp_pr1" "(setq sh_pr1 (get_tile \"gp_pr1\"))")
   (action_tile "gp_pr2" "(setq sh_pr2 (get_tile \"gp_pr2\"))")
   (action_tile "gp_pr3" "(setq sh_pr3 (get_tile \"gp_pr3\"))")
   (action_tile "gp_pr4" "(setq sh_pr4 (get_tile \"gp_pr4\"))")
   (action_tile "gp_pr5" "(setq sh_pr5 (get_tile \"gp_pr5\"))")
   (action_tile "gp_pr6" "(setq sh_pr6 (get_tile \"gp_pr6\"))")
   (action_tile
      "gp_prt1"
      "(setq sh_prt1 (get_tile \"gp_prt1\"))"
   )
   (action_tile
      "gp_prt2"
      "(setq sh_prt2 (get_tile \"gp_prt2\"))"
   )
   (action_tile
      "gp_prt3"
      "(setq sh_prt3 (get_tile \"gp_prt3\"))"
   )
   (action_tile
      "gp_prt4"
      "(setq sh_prt4 (get_tile \"gp_prt4\"))"
   )
   (action_tile
      "gp_prt5"
      "(setq sh_prt5 (get_tile \"gp_prt5\"))"
   )
   (action_tile
      "gp_prt6"
      "(setq sh_prt6 (get_tile \"gp_prt6\"))"
   )												    ;Определение кнопки "Нет"
   (action_tile "cancel" "(done_dialog)(exit)")
												    ;Определение кнопки "Да"
   (action_tile
      "accept"
      (strcat
	 "(setq sh_fio2 (get_tile \"gp_fio2\"))" "(setq sh_fio3 (get_tile \"gp_fio3\"))" "(setq sh_fio4 (get_tile \"gp_fio4\"))"
	 "(setq sh_vid (get_tile \"gp_vid\"))" "(setq rumb_scale_n (get_tile \"gp_scale\"))" "(done_dialog)"
	)
   )
   (start_dialog)
   (unload_dialog sh_dcl)
   (setq rumb_scale (rumb_pp_scale rumb_scale_n))
   (setq rumb_osmode (getvar "osmode"))
   (setvar "osmode" 0)
   (if (= sh_shtamp "1")
      (SHTAMP)
      (if (= sh_uszn "1")
	 (USZN)
	 (if (= sh_prim "1")
	    (PRIM)
	    (setvar "osmode" rumb_osmode)
	 )
      )
   )
)
;;;==========================================================================
(defun SHTAMP ()
   (setq sh_tv
	   (getpoint
	      "Укажите точку вставки правого, нижнего угла штампа"
	   )
   )
   (command "_color" "7")
   (command "_insert" "*rumb_shtamp" sh_tv rumb_scale "0")
   (command "_textstyle" "simplex")
   (command "_layer" "_set" "shtamp" "")							    ;Написание фамилий
   (command "_text"
	    "_j"
	    "_f"
	    (list (+ (* -164 rumb_scale) (car sh_tv)) (+ (* 26 rumb_scale) (cadr sh_tv)))
	    (list (+ (* -146 rumb_scale) (car sh_tv)) (+ (* 26 rumb_scale) (cadr sh_tv)))
	    (* 2.5 rumb_scale)
	    "Животков А.В."
   )
   (if (= sh_fio2 "0")
      (setq sh_fio2_text "Алборов Б.Г.")
   )
   (if (= sh_fio2 "1")
      (setq sh_fio2_text "Бабин А.В.")
   )
   (if (= sh_fio2 "2")
      (setq sh_fio2_text "Борисов А.В.")
   )
   (if (= sh_fio2 "3")
      (setq sh_fio2_text "Веревкин С.И.")
   )
   (if (= sh_fio2 "4")
      (setq sh_fio2_text "Заботин И.В.")
   )
   (if (= sh_fio2 "5")
      (setq sh_fio2_text "Казьмин И.С.")
   )
   (if (= sh_fio2 "6")
      (setq sh_fio2_text "Казьмин О.С.")
   )
   (if (= sh_fio2 "7")
      (setq sh_fio2_text "Квасов В.В.")
   )
   (if (= sh_fio2 "8")
      (setq sh_fio2_text "Пудов Н.В.")
   )
   (if (= sh_fio2 "9")
      (setq sh_fio2_text "Пудов С.В.")
   )
   (if (= sh_fio2 "10")
      (setq sh_fio2_text "Рябов А.В.")
   )
   (if (= sh_fio2 "11")
      (setq sh_fio2_text "Сафонов Д.А.")
   )
   (if (= sh_fio2 "12")
      (setq sh_fio2_text "Слесарев Д.Н.")
   )
   (if (= sh_fio2 "13")
      (setq sh_fio2_text "Соколов А.В.")
   )
   (if (= sh_fio2 "14")
      (setq sh_fio2_text "Строгов А.В.")
   )
   (if (= sh_fio2 "15")
      (setq sh_fio2_text "Тоготин А.А.")
   )
   (if (= sh_fio2 "16")
      (setq sh_fio2_text "Чермашенцев Ю.А.")
   )
   (if (= sh_fio2 "17")
      (setq sh_fio2_text "Шелаев С.Ю.")
   )
   (command "_text"
	    "_j"
	    "_f"
	    (list (+ (* -164 rumb_scale) (car sh_tv)) (+ (* 21 rumb_scale) (cadr sh_tv)))
	    (list (+ (* -146 rumb_scale) (car sh_tv)) (+ (* 21 rumb_scale) (cadr sh_tv)))
	    (* 2.5 rumb_scale)
	    sh_fio2_text
   )
   (if (= sh_fio3 "0")
      (setq sh_fio3_text "Алборов Б.Г.")
   )
   (if (= sh_fio3 "1")
      (setq sh_fio3_text "Бабин А.В.")
   )
   (if (= sh_fio3 "2")
      (setq sh_fio3_text "Борисов А.В.")
   )
   (if (= sh_fio3 "3")
      (setq sh_fio3_text "Веревкин С.И.")
   )
   (if (= sh_fio3 "4")
      (setq sh_fio3_text "Заботин И.В.")
   )
   (if (= sh_fio3 "5")
      (setq sh_fio3_text "Казьмин И.С.")
   )
   (if (= sh_fio3 "6")
      (setq sh_fio3_text "Казьмин О.С.")
   )
   (if (= sh_fio3 "7")
      (setq sh_fio3_text "Королева Л.Н.")
   )
   (if (= sh_fio3 "8")
      (setq sh_fio3_text "Пудов Н.В.")
   )
   (if (= sh_fio3 "9")
      (setq sh_fio3_text "Пудова М.А.")
   )
   (if (= sh_fio3 "10")
      (setq sh_fio3_text "Рябов А.В.")
   )
   (if (= sh_fio3 "11")
      (setq sh_fio3_text "Сафонов Д.А.")
   )
   (if (= sh_fio3 "12")
      (setq sh_fio3_text "Сафонова Т.А.")
   )
   (if (= sh_fio3 "13")
      (setq sh_fio3_text "Слесарев Д.Н.")
   )
   (if (= sh_fio3 "14")
      (setq sh_fio3_text "Соколов А.В.")
   )
   (if (= sh_fio3 "15")
      (setq sh_fio3_text "Строгов А.В.")
   )
   (if (= sh_fio3 "16")
      (setq sh_fio3_text "Тоготин А.А.")
   )
   (if (= sh_fio3 "17")
      (setq sh_fio3_text "Чермашенцев Ю.А.")
   )
   (if (= sh_fio3 "18")
      (setq sh_fio3_text "Чернышева М.Э.")
   )
   (if (= sh_fio3 "20")
      (setq sh_fio3_text "Шелаев С.Ю.")
   )
   (command "_text"
	    "_j"
	    "_f"
	    (list (+ (* -164 rumb_scale) (car sh_tv)) (+ (* 16 rumb_scale) (cadr sh_tv)))
	    (list (+ (* -146 rumb_scale) (car sh_tv)) (+ (* 16 rumb_scale) (cadr sh_tv)))
	    (* 2.5 rumb_scale)
	    sh_fio3_text
   )
   (if (= sh_fio4 "0")
      (setq sh_fio4_text "Алборов Б.Г.")
   )
   (if (= sh_fio4 "1")
      (setq sh_fio4_text "Бабин А.В.")
   )
   (if (= sh_fio4 "2")
      (setq sh_fio4_text "Пудов С.В.")
   )
   (if (= sh_fio4 "3")
      (setq sh_fio4_text "Рябов А.В.")
   )
   (command "_text"
	    "_j"
	    "_f"
	    (list (+ (* -164 rumb_scale) (car sh_tv)) (+ (* 11 rumb_scale) (cadr sh_tv)))
	    (list (+ (* -146 rumb_scale) (car sh_tv)) (+ (* 11 rumb_scale) (cadr sh_tv)))
	    (* 2.5 rumb_scale)
	    sh_fio4_text
   )												    ;Написание заказа
   (command "_text"
	    "_j"
	    "_c"
	    (list (+ (* -74 rumb_scale) (car sh_tv)) (+ (* 47 rumb_scale) (cadr sh_tv)))
	    (* 5 rumb_scale)
	    "0"
	    sh_zakaz
   )												    ;Написание кода
   (command "_text"
	    (list (+ (* -14 rumb_scale) (car sh_tv)) (+ (* 52 rumb_scale) (cadr sh_tv)))
	    (* 2 rumb_scale)
	    "0"
	    sh_kod
   )												    ;Написание объекта
   (if (/= sh_ob2 "")
      (progn (if (>= (strlen sh_ob1) 50)
		(command "_text"
			 "_j"
			 "_f"
			 (list (+ (* -118 rumb_scale) (car sh_tv)) (+ (* 39 rumb_scale) (cadr sh_tv)))
			 (list (+ (* -2 rumb_scale) (car sh_tv)) (+ (* 39 rumb_scale) (cadr sh_tv)))
			 (* 2.5 rumb_scale)
			 sh_ob1
		)
		(command "_text"
			 "_j"
			 "_c"
			 (list (+ (* -60 rumb_scale) (car sh_tv)) (+ (* 39 rumb_scale) (cadr sh_tv)))
			 (* 2.5 rumb_scale)
			 "0"
			 sh_ob1
		)
	     )
	     (if (>= (strlen sh_ob2) 50)
		(command "_text"
			 "_j"
			 "_f"
			 (list (+ (* -118 rumb_scale) (car sh_tv)) (+ (* 33 rumb_scale) (cadr sh_tv)))
			 (list (+ (* -2 rumb_scale) (car sh_tv)) (+ (* 33 rumb_scale) (cadr sh_tv)))
			 (* 2.5 rumb_scale)
			 sh_ob2
		)
		(command "_text"
			 "_j"
			 "_c"
			 (list (+ (* -60 rumb_scale) (car sh_tv)) (+ (* 33 rumb_scale) (cadr sh_tv)))
			 (* 2.5 rumb_scale)
			 "0"
			 sh_ob2
		)
	     )
      )
      (if (>= (strlen sh_ob1) 50)
	 (command "_text"
		  "_j"
		  "_f"
		  (list (+ (* -118 rumb_scale) (car sh_tv)) (+ (* 36 rumb_scale) (cadr sh_tv)))
		  (list (+ (* -2 rumb_scale) (car sh_tv)) (+ (* 36 rumb_scale) (cadr sh_tv)))
		  (* 2.5 rumb_scale)
		  sh_ob1
	 )
	 (command "_text"
		  "_j"
		  "_c"
		  (list (+ (* -60 rumb_scale) (car sh_tv)) (+ (* 36 rumb_scale) (cadr sh_tv)))
		  (* 2.5 rumb_scale)
		  "0"
		  sh_ob1
	 )
      )
   )												    ;Написание вида документа
   (if (= sh_vid "0")
      (setq sh_vid_text "Схема выноса в натуру")
   )
   (if (= sh_vid "1")
      (setq sh_vid_text "Топографический план")
   )
   (if (= sh_vid "2")
      (setq sh_vid_text "Схема планового обоснования")
   )
   (if (= sh_vid "3")
      (setq sh_vid_text "Корректировка плана местности")
   )
   (if (= sh_vid "4")
      (setq sh_vid_text "Разбивочный чертеж")
   )
   (if (= sh_vid "5")
      (setq sh_vid_text "Конструктивный чертеж")
   )
   (if (= sh_vid "6")
      (setq sh_vid_text "План земляных масс")
   )
   (if (= sh_vid "7")
      (setq sh_vid_text "Схема планового положения")
   )
   (if (and (= sh_vid1 "") (= sh_vid2 ""))
      (command "_text"
	       "_j"
	       "_c"
	       (list (+ (* -85 rumb_scale) (car sh_tv)) (+ (* 21.5 rumb_scale) (cadr sh_tv)))
	       (* 2.5 rumb_scale)
	       "0"
	       sh_vid_text
      )
      (if (= sh_vid2 "")
	 (progn
	    (command "_text"
		     "_j"
		     "_c"
		     (list (+ (* -85 rumb_scale) (car sh_tv)) (+ (* 23.5 rumb_scale) (cadr sh_tv)))
		     (* 2.5 rumb_scale)
		     "0"
		     sh_vid_text
	    )
	    (if	(>= (strlen sh_vid1) 28)
	       (command	"_text"
			"_j"
			"_f"
			(list (+ (* -117 rumb_scale) (car sh_tv)) (+ (* 19 rumb_scale) (cadr sh_tv)))
			(list (+ (* -52 rumb_scale) (car sh_tv)) (+ (* 19 rumb_scale) (cadr sh_tv)))
			(* 2.5 rumb_scale)
			sh_vid1
	       )
	       (command	"_text"
			"_j"
			"_c"
			(list (+ (* -85 rumb_scale) (car sh_tv)) (+ (* 19 rumb_scale) (cadr sh_tv)))
			(* 2.5 rumb_scale)
			"0"
			sh_vid1
	       )
	    )
	 )
	 (progn
	    (command "_text"
		     "_j"
		     "_c"
		     (list (+ (* -85 rumb_scale) (car sh_tv)) (+ (* 26 rumb_scale) (cadr sh_tv)))
		     (* 2.5 rumb_scale)
		     "0"
		     sh_vid_text
	    )
	    (if	(>= (strlen sh_vid1) 28)
	       (command
		  "_text"
		  "_j"
		  "_f"
		  (list (+ (* -117 rumb_scale) (car sh_tv)) (+ (* 21.5 rumb_scale) (cadr sh_tv)))
		  (list (+ (* -52 rumb_scale) (car sh_tv)) (+ (* 21.5 rumb_scale) (cadr sh_tv)))
		  (* 2.5 rumb_scale)
		  sh_vid1
	       )
	       (command
		  "_text"
		  "_j"
		  "_c"
		  (list (+ (* -85 rumb_scale) (car sh_tv)) (+ (* 21.5 rumb_scale) (cadr sh_tv)))
		  (* 2.5 rumb_scale)
		  "0"
		  sh_vid1
	       )
	    )
	    (if	(>= (strlen sh_vid2) 28)
	       (command	"_text"
			"_j"
			"_f"
			(list (+ (* -117 rumb_scale) (car sh_tv)) (+ (* 17 rumb_scale) (cadr sh_tv)))
			(list (+ (* -52 rumb_scale) (car sh_tv)) (+ (* 17 rumb_scale) (cadr sh_tv)))
			(* 2.5 rumb_scale)
			sh_vid2
	       )
	       (command	"_text"
			"_j"
			"_c"
			(list (+ (* -85 rumb_scale) (car sh_tv)) (+ (* 17 rumb_scale) (cadr sh_tv)))
			(* 2.5 rumb_scale)
			"0"
			sh_vid2
	       )
	    )
	 )
      )
   )												    ;Написание листов
   (command "_text"
	    "_j"
	    "_c"
	    (list (+ (* -27 rumb_scale) (car sh_tv)) (+ (* 18 rumb_scale) (cadr sh_tv)))
	    (* 4 rumb_scale)
	    "0"
	    sh_list
   )
   (command "_text"
	    "_j"
	    "_c"
	    (list (+ (* -9.75 rumb_scale) (car sh_tv)) (+ (* 18 rumb_scale) (cadr sh_tv)))
	    (* 4 rumb_scale)
	    "0"
	    sh_lists
   )												    ;Написание масштаба
   (if (= rumb_scale_n "0")
      (setq rumb_scale_text "")
   )
   (if (= rumb_scale_n "1")
      (setq rumb_scale_text "М-б 1:100")
   )
   (if (= rumb_scale_n "2")
      (setq rumb_scale_text "М-б 1:200")
   )
   (if (= rumb_scale_n "3")
      (setq rumb_scale_text "М-б 1:500")
   )
   (if (= rumb_scale_n "4")
      (setq rumb_scale_text "М-б 1:1000")
   )
   (if (= rumb_scale_n "5")
      (setq rumb_scale_text "М-б 1:2000")
   )
   (if (= rumb_scale_n "6")
      (setq rumb_scale_text "М-б 1:5000")
   )
   (if (= rumb_scale_n "7")
      (setq rumb_scale_text "М-б 1:10000")
   )
   (if (= rumb_scale_n "8")
      (setq rumb_scale_text "М-б 1:20000")
   )
   (if (= rumb_scale_n "9")
      (setq rumb_scale_text "М-б 1:50000")
   )
   (command "_text"
	    "_j"
	    "_c"
	    (list (+ (* -83.75 rumb_scale) (car sh_tv))
		  (+ (* 4 rumb_scale) (cadr sh_tv))
	    )
	    (* 4 rumb_scale)
	    "0"
	    rumb_scale_text
   )
   (if (= sh_uszn "1")
      (USZN)
      (if (= sh_prim "1")
	 (PRIM)
	 (setvar "osmode" rumb_osmode)
      )
   )
)
;;;==========================================================================
(defun USZN ()
   (setq us_tv
	   (getpoint "Укажите точку вставки условных обозначений")
   )
   (command "_color" "7")
   (command "_insert" "*rumb_uspr" us_tv rumb_scale "0")
   (command "_textstyle" "simplex")
   (command "_layer" "_set" "shtamp" "")
   (command "_text"
	    us_tv
	    (* 4 rumb_scale)
	    "0"
	    "УСЛОВНЫЕ ОБОЗНАЧЕНИЯ"
   )
   (setq us_tv (list (car us_tv) (- (cadr us_tv) (* 5 rumb_scale))))
   (if (= sh_usdr "1")
      (progn (command "_color" "7")
	     (command "_line"
		      (list (+ (car us_tv) (* 2 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      (list (+ (car us_tv) (* 18 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      ""
	     )
	     (command "_circle"
		      (list (+ (car us_tv) (* 10 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      (* 0.25 rumb_scale)
	     )
	     (command
		"_text"
		(list (+ (car us_tv) (* 20 rumb_scale)) (cadr us_tv))
		(* 2.5 rumb_scale)
		"0"
		"дорога"
	     )
	     (setq us_tv (list (car us_tv)
			       (- (cadr us_tv) (* 4 rumb_scale))
			 )
	     )
      )
   )
   (if (= sh_usvs "1")
      (progn (command "_color" "4")
	     (command "_line"
		      (list (+ (car us_tv) (* 2 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      (list (+ (car us_tv) (* 18 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      ""
	     )
	     (command "_circle"
		      (list (+ (car us_tv) (* 10 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      (* 0.25 rumb_scale)
	     )
	     (command "_color" "7")
	     (command
		"_text"
		(list (+ (car us_tv) (* 20 rumb_scale)) (cadr us_tv))
		(* 2.5 rumb_scale)
		"0"
		"водосток"
	     )
	     (setq us_tv (list (car us_tv)
			       (- (cadr us_tv) (* 4 rumb_scale))
			 )
	     )
      )
   )
   (if (= sh_usvp "1")
      (progn (command "_color" "5")
	     (command "_line"
		      (list (+ (car us_tv) (* 2 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      (list (+ (car us_tv) (* 18 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      ""
	     )
	     (command "_circle"
		      (list (+ (car us_tv) (* 10 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      (* 0.25 rumb_scale)
	     )
	     (command "_color" "7")
	     (command
		"_text"
		(list (+ (car us_tv) (* 20 rumb_scale)) (cadr us_tv))
		(* 2.5 rumb_scale)
		"0"
		"водопровод"
	     )
	     (setq us_tv (list (car us_tv)
			       (- (cadr us_tv) (* 4 rumb_scale))
			 )
	     )
      )
   )
   (if (= sh_uskn "1")
      (progn (command "_color" "3")
	     (command "_line"
		      (list (+ (car us_tv) (* 2 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      (list (+ (car us_tv) (* 18 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      ""
	     )
	     (command "_circle"
		      (list (+ (car us_tv) (* 10 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      (* 0.25 rumb_scale)
	     )
	     (command "_color" "7")
	     (command
		"_text"
		(list (+ (car us_tv) (* 20 rumb_scale)) (cadr us_tv))
		(* 2.5 rumb_scale)
		"0"
		"канализация"
	     )
	     (setq us_tv (list (car us_tv)
			       (- (cadr us_tv) (* 4 rumb_scale))
			 )
	     )
      )
   )
   (if (= sh_usgz "1")
      (progn (command "_color" "1")
	     (command "_line"
		      (list (+ (car us_tv) (* 2 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      (list (+ (car us_tv) (* 18 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      ""
	     )
	     (command "_circle"
		      (list (+ (car us_tv) (* 10 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      (* 0.25 rumb_scale)
	     )
	     (command "_color" "7")
	     (command
		"_text"
		(list (+ (car us_tv) (* 20 rumb_scale)) (cadr us_tv))
		(* 2.5 rumb_scale)
		"0"
		"газопровод"
	     )
	     (setq us_tv (list (car us_tv)
			       (- (cadr us_tv) (* 4 rumb_scale))
			 )
	     )
      )
   )
   (if (= sh_ustp "1")
      (progn (command "_color" "1")
	     (command "_line"
		      (list (+ (car us_tv) (* 2 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      (list (+ (car us_tv) (* 18 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      ""
	     )
	     (command "_circle"
		      (list (+ (car us_tv) (* 10 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      (* 0.25 rumb_scale)
	     )
	     (command "_color" "7")
	     (command
		"_text"
		(list (+ (car us_tv) (* 20 rumb_scale)) (cadr us_tv))
		(* 2.5 rumb_scale)
		"0"
		"теплосеть"
	     )
	     (setq us_tv (list (car us_tv)
			       (- (cadr us_tv) (* 4 rumb_scale))
			 )
	     )
      )
   )
   (if (= sh_usek "1")
      (progn (command "_color" "6")
	     (command "_line"
		      (list (+ (car us_tv) (* 2 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      (list (+ (car us_tv) (* 18 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      ""
	     )
	     (command "_circle"
		      (list (+ (car us_tv) (* 10 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      (* 0.25 rumb_scale)
	     )
	     (command "_color" "7")
	     (command
		"_text"
		(list (+ (car us_tv) (* 20 rumb_scale)) (cadr us_tv))
		(* 2.5 rumb_scale)
		"0"
		"электрокабель"
	     )
	     (setq us_tv (list (car us_tv)
			       (- (cadr us_tv) (* 4 rumb_scale))
			 )
	     )
      )
   )
   (if (= sh_usks "1")
      (progn (command "_color" "6")
	     (command "_line"
		      (list (+ (car us_tv) (* 2 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      (list (+ (car us_tv) (* 18 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      ""
	     )
	     (command "_circle"
		      (list (+ (car us_tv) (* 10 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      (* 0.25 rumb_scale)
	     )
	     (command "_color" "7")
	     (command
		"_text"
		(list (+ (car us_tv) (* 20 rumb_scale)) (cadr us_tv))
		(* 2.5 rumb_scale)
		"0"
		"кабель связи"
	     )
	     (setq us_tv (list (car us_tv)
			       (- (cadr us_tv) (* 4 rumb_scale))
			 )
	     )
      )
   )
   (if (= sh_uspo "1")
      (progn (command "_color" "1")
	     (command "_line"
		      (list (+ (car us_tv) (* 2 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      (list (+ (car us_tv) (* 18 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      ""
	     )
	     (command "_circle"
		      (list (+ (car us_tv) (* 10 rumb_scale))
			    (+ (cadr us_tv) (* 1 rumb_scale))
		      )
		      (* 0.25 rumb_scale)
	     )
	     (command "_color" "7")
	     (command
		"_text"
		(list (+ (car us_tv) (* 20 rumb_scale)) (cadr us_tv))
		(* 2.5 rumb_scale)
		"0"
		"полоса отвода"
	     )
	     (setq us_tv (list (car us_tv)
			       (- (cadr us_tv) (* 4 rumb_scale))
			 )
	     )
      )
   )
   (if (= sh_usgd "1")
      (progn (command "_color" "7")
	     (command "_line"
		      (list (+ (car us_tv) (* 2 rumb_scale))
			    (- (cadr us_tv) (* 1 rumb_scale))
		      )
		      (list (+ (car us_tv) (* 8.5 rumb_scale))
			    (- (cadr us_tv) (* 1 rumb_scale))
		      )
		      ""
	     )
	     (command "_line"
		      (list (+ (car us_tv) (* 11.5 rumb_scale))
			    (- (cadr us_tv) (* 1 rumb_scale))
		      )
		      (list (+ (car us_tv) (* 18 rumb_scale))
			    (- (cadr us_tv) (* 1 rumb_scale))
		      )
		      ""
	     )
	     (command "_circle"
		      (list (+ (car us_tv) (* 10 rumb_scale))
			    (- (cadr us_tv) (* 1 rumb_scale))
		      )
		      (* 0.5 rumb_scale)
	     )
	     (command "_line"
		      (list (+ (car us_tv) (* 9 rumb_scale))
			    (- (cadr us_tv) (* 1 rumb_scale))
		      )
		      (list (+ (car us_tv) (* 9.5 rumb_scale))
			    (- (cadr us_tv) (* 1 rumb_scale))
		      )
		      ""
	     )
	     (command "_line"
		      (list (+ (car us_tv) (* 10.5 rumb_scale))
			    (- (cadr us_tv) (* 1 rumb_scale))
		      )
		      (list (+ (car us_tv) (* 11 rumb_scale))
			    (- (cadr us_tv) (* 1 rumb_scale))
		      )
		      ""
	     )
	     (command
		"_line"
		(list (+ (car us_tv) (* 10 rumb_scale)) (cadr us_tv))
		(list (+ (car us_tv) (* 10 rumb_scale))
		      (- (cadr us_tv) (* 0.5 rumb_scale))
		)
		""
	     )
	     (command "_line"
		      (list (+ (car us_tv) (* 10 rumb_scale))
			    (- (cadr us_tv) (* 1.5 rumb_scale))
		      )
		      (list (+ (car us_tv) (* 10 rumb_scale))
			    (- (cadr us_tv) (* 2 rumb_scale))
		      )
		      ""
	     )
	     (command
		"_text"
		(list (+ (car us_tv) (* 20 rumb_scale)) (cadr us_tv))
		(* 2.5 rumb_scale)
		"0"
		"точки и стороны"
	     )
	     (setq us_tv (list (car us_tv)
			       (- (cadr us_tv) (* 3 rumb_scale))
			 )
	     )
	     (command
		"_text"
		(list (+ (car us_tv) (* 20 rumb_scale)) (cadr us_tv))
		(* 2.5 rumb_scale)
		"0"
		"геодезического обоснования"
	     )
	     (setq us_tv (list (car us_tv)
			       (- (cadr us_tv) (* 4 rumb_scale))
			 )
	     )
	     (command "_color" "1")
	     (command "_circle"
		      (list (+ (car us_tv) (* 10 rumb_scale))
			    (- (cadr us_tv) (* 1 rumb_scale))
		      )
		      (* 0.1 rumb_scale)
	     )
	     (command
		"_line"
		(list (+ (car us_tv) (* 10 rumb_scale))
		      (+ (cadr us_tv) (* 0.73 rumb_scale))
		)
		(list (+ (car us_tv) (* 11.5 rumb_scale))
		      (- (cadr us_tv) (* 1.87 rumb_scale))
		)
		(list (+ (car us_tv) (* 8.5 rumb_scale))
		      (- (cadr us_tv) (* 1.87 rumb_scale))
		)
		(list (+ (car us_tv) (* 10 rumb_scale))
		      (+ (cadr us_tv) (* 0.73 rumb_scale))
		)
		""
	     )
	     (command "_color" "7")
	     (command
		"_text"
		(list (+ (car us_tv) (* 20 rumb_scale)) (cadr us_tv))
		(* 2.5 rumb_scale)
		"0"
		"исходные пункты"
	     )
	     (setq us_tv (list (car us_tv)
			       (- (cadr us_tv) (* 3 rumb_scale))
			 )
	     )
	     (command
		"_text"
		(list (+ (car us_tv) (* 20 rumb_scale)) (cadr us_tv))
		(* 2.5 rumb_scale)
		"0"
		"геодезического обоснования"
	     )
	     (setq us_tv (list (car us_tv)
			       (- (cadr us_tv) (* 4 rumb_scale))
			 )
	     )
      )
   )
   (if (= sh_prim "1")
      (PRIM)
      (setvar "osmode" rumb_osmode)
   )
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun PRIM ()
   (setq pr_tv (getpoint "Укажите точку вставки примечаний"))
   (setq pr_text1 "")
   (setq pr_text2 "")
   (setq pr_text3 "")
   (setq pr_text4 "")
   (setq pr_text5 "")
   (setq pr_text6 "")
   (setq pr_n 0)
   (setq pr_n1 0)
   (setq pr_n2 0)
   (setq pr_n3 0)
   (setq pr_n4 0)
   (setq pr_n5 0)
   (setq pr_n6 0)
   (if (= sh_pr1 "1")
      (progn (setq pr_n 1) (setq pr_n1 pr_n))
   )
   (if (= sh_pr2 "1")
      (progn (setq pr_n (+ pr_n 1)) (setq pr_n2 pr_n))
   )
   (if (= sh_pr3 "1")
      (progn (setq pr_n (+ pr_n 1)) (setq pr_n3 pr_n))
   )
   (if (= sh_pr4 "1")
      (progn (setq pr_n (+ pr_n 1)) (setq pr_n4 pr_n))
   )
   (if (= sh_pr5 "1")
      (progn (setq pr_n (+ pr_n 1)) (setq pr_n5 pr_n))
   )
   (if (= sh_pr6 "1")
      (progn (setq pr_n (+ pr_n 1)) (setq pr_n6 pr_n))
   )
   (if (= pr_n1 1)
      (setq pr_text1 (strcat "1. " sh_prt1))
   )
   (if (= pr_n2 1)
      (setq pr_text1 (strcat "1. " sh_prt2))
   )
   (if (= pr_n2 2)
      (setq pr_text2 (strcat "2. " sh_prt2))
   )
   (if (= pr_n3 1)
      (setq pr_text1 (strcat "1. " sh_prt3))
   )
   (if (= pr_n3 2)
      (setq pr_text2 (strcat "2. " sh_prt3))
   )
   (if (= pr_n3 3)
      (setq pr_text3 (strcat "3. " sh_prt3))
   )
   (if (= pr_n4 1)
      (setq pr_text1 (strcat "1. " sh_prt4))
   )
   (if (= pr_n4 2)
      (setq pr_text2 (strcat "2. " sh_prt4))
   )
   (if (= pr_n4 3)
      (setq pr_text3 (strcat "3. " sh_prt4))
   )
   (if (= pr_n4 4)
      (setq pr_text4 (strcat "4. " sh_prt4))
   )
   (if (= pr_n5 1)
      (setq pr_text1 (strcat "1. " sh_prt5))
   )
   (if (= pr_n5 2)
      (setq pr_text2 (strcat "2. " sh_prt5))
   )
   (if (= pr_n5 3)
      (setq pr_text3 (strcat "3. " sh_prt5))
   )
   (if (= pr_n5 4)
      (setq pr_text4 (strcat "4. " sh_prt5))
   )
   (if (= pr_n5 5)
      (setq pr_text5 (strcat "5. " sh_prt5))
   )
   (if (= pr_n6 1)
      (setq pr_text1 (strcat "1. " sh_prt6))
   )
   (if (= pr_n6 2)
      (setq pr_text2 (strcat "2. " sh_prt6))
   )
   (if (= pr_n6 3)
      (setq pr_text3 (strcat "3. " sh_prt6))
   )
   (if (= pr_n6 4)
      (setq pr_text4 (strcat "4. " sh_prt6))
   )
   (if (= pr_n6 5)
      (setq pr_text5 (strcat "5. " sh_prt6))
   )
   (if (= pr_n6 6)
      (setq pr_text6 (strcat "6. " sh_prt6))
   )
   (command "_color" "7")
   (command "_insert" "*rumb_uspr" pr_tv rumb_scale "0")
   (command "_textstyle" "simplex")
   (command "_layer" "_set" "shtamp" "")
   (command "_mtext"
	    pr_tv
	    "_h"
	    (* 2.5 rumb_scale)
	    (list (+ (car pr_tv) (* 100 rumb_scale))
		  (- (cadr pr_tv) (* 100 rumb_scale))
	    )
	    "Примечания :"
	    pr_text1
	    pr_text2
	    pr_text3
	    pr_text4
	    pr_text5
	    pr_text6
	    ""
   )
   (setvar "osmode" rumb_osmode)
)
;;;=========================================================================
;;;=========================================================================
;;;=========================================================================
;;;=========================================================================
;;;=========================================================================
(defun C:str ()
   (if (= rumb_scale_n nil)
      (setq rumb_scale_n "3")
   )
   (setq otk_dcl (load_dialog "rumb.dcl"))
   (if (not (new_dialog "otkos" otk_dcl))
      (exit)
   )
   (set_tile "gp_scale" rumb_scale_n)								    ;Определение кнопки "Нет"
   (action_tile "cancel" "(done_dialog)(exit)")
												    ;Определение кнопки "Да"
   (action_tile
      "accept"
      (strcat "(setq rumb_scale_n (get_tile \"gp_scale\"))"
	      "(done_dialog)"
      )
   )
   (start_dialog)
   (unload_dialog otk_dcl)
   (if (= rumb_scale_n "0")
      (setq rumb_scale 1)
   )
   (if (= rumb_scale_n "1")
      (setq rumb_scale 0.1)
   )
   (if (= rumb_scale_n "2")
      (setq rumb_scale 0.2)
   )
   (if (= rumb_scale_n "3")
      (setq rumb_scale 0.5)
   )
   (if (= rumb_scale_n "4")
      (setq rumb_scale 1)
   )
   (if (= rumb_scale_n "5")
      (setq rumb_scale 2)
   )
   (if (= rumb_scale_n "6")
      (setq rumb_scale 5)
   )
   (if (= rumb_scale_n "7")
      (setq rumb_scale 10)
   )
   (if (= rumb_scale_n "8")
      (setq rumb_scale 20)
   )
   (if (= rumb_scale_n "9")
      (setq rumb_scale 50)
   )
   (str1)
)
(defun str1 ()
   (setq str_t1 (getpoint "\nУкажите 1-ую точку стрелки: "))
   (setq str_t2 (getpoint "\nУкажите 2-ую точку стрелки: "))
   (setq rumb_osmode (getvar "osmode"))
   (setvar "osmode" 0)
   (command "_ucs" "_o" str_t1)
   (command "_ucs" "_z" str_t1 str_t2)
   (Command "_solid"
	    (list (* 4 rumb_scale) rumb_scale)
	    (list (* 4 rumb_scale) rumb_scale)
	    "0,0"
	    (list (* 2 rumb_scale) 0)
	    (list (* 4 rumb_scale) (* -1 rumb_scale))
	    (list (* 4 rumb_scale) (* -1 rumb_scale))
	    ""
   )
   (command "_ucs" "_w")
   (setvar "osmode" rumb_osmode)
   (str2)
)
(defun str2 () (str1))
;;;================================================================================================
;;;================================================================================================
;;;================================================================================================
;;; Общая подпрограмма=============================================================================
;;; Установка масштабных коэффициентов=============================================================
(defun rumb_pp_scale (rumb_scale_n)
   (if (= rumb_scale_n "0")
      1
      (if (= rumb_scale_n "1")
	 0.1
	 (if (= rumb_scale_n "2")
	    0.2
	    (if	(= rumb_scale_n "3")
	       0.5
	       (if (= rumb_scale_n "4")
		  1
		  (if (= rumb_scale_n "5")
		     2
		     (if (= rumb_scale_n "6")
			5
			(if (= rumb_scale_n "7")
			   10
			   (if (= rumb_scale_n "8")
			      20
			      (if (= rumb_scale_n "9")
				 50
			      )
			   )
			)
		     )
		  )
	       )
	    )
	 )
      )
   )
)
;;;================================================================================================
;;;================================================================================================
;;;================================================================================================
;;; Общие подпрограммы=============================================================================
;;; Управление слоями==============================================================================
(defun rumb_pp_lay1 (/ rumb_lay rumb_lay_num)
   (start_list "gpr_pl_lay")
   (setq rumb_lay (tblnext "layer" T))
   (add_list "0")
   (setq rumb_lay_list nil)
   (setq rumb_lay_list (cons "0" rumb_lay_list))
   (setq rumb_lay_num 0)
   (setq rumb_lay_cur_num 0)
   (while (/= rumb_lay nil)
      (setq rumb_lay_num (+ 1 rumb_lay_num))
      (setq rumb_lay (tblnext "layer"))
      (if (/= rumb_lay nil)
	 (progn
	    (add_list (cdr (assoc 2 rumb_lay)))
	    (setq rumb_lay_list (cons (cdr (assoc 2 rumb_lay)) rumb_lay_list))
	    (if	(= (cdr (assoc 2 rumb_lay)) (getvar "clayer"))
	       (setq rumb_lay_cur_num rumb_lay_num)
	    )
	 )
      )
   )
   (end_list)
   (setq rumb_t_lay_new "0")
   (set_tile "gpr_pl_lay" (itoa rumb_lay_cur_num))
   (set_tile "gpr_eb_nlay" rumb_lay_nam)
   (action_tile "gpr_pl_lay" "(setq rumb_lay_cur_num (atoi (get_tile \"gpr_pl_lay\")))")
   (action_tile	"gpr_t_nlay"
		(strcat
		   "(setq rumb_t_lay_new (get_tile \"gpr_t_nlay\"))"
		   "(if (= rumb_t_lay_new \"0\")"
		   "(progn (mode_tile \"gpr_eb_nlay\" 1)(mode_tile \"gpr_pl_lay\" 0))"
		   "(progn (mode_tile \"gpr_eb_nlay\" 0)(mode_tile \"gpr_pl_lay\" 1)))"
		)
   )
   (action_tile "gpr_eb_nlay" "(setq rumb_lay_nam (get_tile \"gpr_eb_nlay\"))")
)
(defun rumb_pp_lay2 ()
   (if (= rumb_t_lay_new "0")
      (command "_layer" "_s" (nth rumb_lay_cur_num (reverse rumb_lay_list)) "")
      (command "_layer" "_n" rumb_lay_nam "_s" rumb_lay_nam "")
   )
)
;;;================================================================================================
;;;================================================================================================
;;;================================================================================================
;;; Общая подпрограмма=============================================================================
;;; Отрисовка полилинии по списку==================================================================
(defun rumb_pp_pline (rumb_pline_list)
   (eval (append (list 'command '"_PLINE") rumb_pline_list (list '"")))
)
;;;================================================================================================
;;;================================================================================================
;;;================================================================================================
;;;================================================================================================
;;;================================================================================================
;|«Visual LISP© Format Options»
(150 3 100 2 nil "конец " 100 150 0 0 1 T T nil T)
;*** НЕ добавляейте текст под комментариями! ***|;
