rumb_icon: dialog {
        key = "label";
        initial_focus               = "listbox";
        : row {
            : list_box {
                width               = 20;
                height              = 21;
                fixed_height        = true;
                key                 = "listbox";
                allow_accept        = true;
            }
            : column {
                : row {
                    : icon_image {
                        key         = "icon1";
                    }
                    : icon_image {
                        key         = "icon2";
                    }
                    : icon_image {
                        key         = "icon3";
                    }
                    : icon_image {
                        key         = "icon4";
                    }
                }
                : row {
                    : icon_image {
                        key         = "icon5";
                    }
                    : icon_image {
                        key         = "icon6";
                    }
                    : icon_image {
                        key         = "icon7";
                    }
                    : icon_image {
                        key         = "icon8";
                    }
                }
                : row {
                    : icon_image {
                        key         = "icon9";
                    }
                    : icon_image {
                        key         = "icon10";
                    }
                    : icon_image {
                        key         = "icon11";
                    }
                    : icon_image {
                        key         = "icon12";
                    }
                }
                : row {
                    : icon_image {
                        key         = "icon13";
                    }
                    : icon_image {
                        key         = "icon14";
                    }
                    : icon_image {
                        key         = "icon15";
                    }
                    : icon_image {
                        key         = "icon16";
                    }
                }
                : row {
                    : icon_image {
                        key         = "icon17";
                    }
                    : icon_image {
                        key         = "icon18";
                    }
                    : icon_image {
                        key         = "icon19";
                    }
                    : icon_image {
                        key         = "icon20";
                    }
                }
/*
 *              : row {
 *                  : icon_image {
 *                      key         = "icon21";
 *                  }
 *                  : icon_image {
 *                      key         = "icon22";
 *                  }
 *                  : icon_image {
 *                      key         = "icon23";
 *                  }
 *                  : icon_image {
 *                      key         = "icon24";
 *                  }
 *              }
 */
            }
        }
        : row {
            : row {
                spacer_0;
                : row {
                    fixed_width = true;
                    : button {
                        label = "&Previous";
                        key = "prev";
                        width = 8;
                    }
                    :spacer {
                        width = 2;
                    }
                    :button {
                        label = "  &Next  ";
                        key = "next";
                        width = 8;
                    }
                }
                spacer_0;
            }
            spacer;
            ok_cancel;
        }
}
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//Элемент "СЛОЙ"==================================================================================
rumb_layer : boxed_row {
			label = "Слой";
			width = 50;
			fixed_width = true;
			: popup_list {
				key = "gpr_pl_lay";
				edit_width = 15;
				value = "1";
			}
			spacer;
			: toggle {
				label = "Новый";
				key = "gpr_t_nlay";
				value = "0";
			}
			: edit_box {
				key = "gpr_eb_nlay";
				is_enabled = false;
				edit_width = 12;
				}
}
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//Элемент "Масштаб"===============================================================================
rumb_scale : popup_list {
		label = "Масштаб";
		key = "gp_scale";
		edit_width = 8;
		list = "нет\n1/100\n1/200\n1/500\n1/1000\n1/2000\n1/5000\n1/10000\n1/20000\n1/50000";
}
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//Диалоговое окно "Профиль"=======================================================================
profil : dialog {
	label = "Отрисовка профиля";
	rumb_layer;
	:row {
		: boxed_radio_row {
			label = "1-ая графа отметки";
			width = 46;
			: column {
				: popup_list {
					key = "gp_prf_otm1";
					value = "1";
					edit_width = 15;
					fixed_width = true;
					list = "Не подписывать\nПо центру\nНад чертой";
				}
				: toggle {
					label = "Соединительные линии";
					key = "gp_prf_sline1";
					value = "1";
				}
			}
			: column {
				: toggle {
					label = "Ординаты";
					key = "gp_prf_ord1";
					value = "1";
				}
				: toggle {
					label = "Точки";
					key = "gp_prf_tchk1";
					value = "1";
				}
			}
		}
		: boxed_column {
			width = 46;
			: popup_list {
				label = "Графа расстояния        ";
				key = "gp_prf_ras";
				value = "0";
				edit_width = 15;
				list = "Не выводить\nВыводить";
			}
			: popup_list {
				label = "Названия подписывать";
				key = "gp_prf_namegv";
				edit_width = 15;
				value = "1";
				list = "Не подписывать\nГоризонтально\nВертикально";
			}
		}
	}
	: row {
		: boxed_radio_row {
			label = "2-ая графа отметки";
			width = 46;
			: column {
				: popup_list {
					key = "gp_prf_otm2";
					value = "1";
					edit_width = 15;
					fixed_width = true;
					list = "Не подписывать\nПо центру\nНад чертой";
				}
				: toggle {
					label = "Соединительные линии";
					key = "gp_prf_sline2";
					value = "1";
				}
			}
			: column {
				: toggle {
					label = "Ординаты";
					key = "gp_prf_ord2";
					value = "1";
				}
				: toggle {
					label = "Точки";
					key = "gp_prf_tchk2";
					value = "1";
				}
			}
		}
		: boxed_radio_column {
			width = 46;
			: popup_list{
				label = "Графа уклоны";
				key = "gp_prf_ukl";
				edit_width = 15;
				list = "Не выводить\nПо 1-му уровню\nПо 2-му уровню\nПо 3-му уровню";
			}
			: popup_list {
				label = "Размерность            ";
				key = "gp_prf_uklr";
				edit_width = 15;
				list = "*1\n*10\n*100\n*1000";
			}
		}
	}
	: row {
		: boxed_radio_row {
			label = "3-я графа отметки";
			width = 46;
			: column {
				: popup_list {
					key = "gp_prf_otm3";
					value = "1";
					edit_width = 15;
					fixed_width = true;
					list = "Не подписывать\nПо центру\nНад чертой";
				}
				: toggle {
					label = "Соединительные линии";
					key = "gp_prf_sline3";
					value = "1";
				}
			}
			: column {
				: toggle {
					label = "Ординаты";
					key = "gp_prf_ord3";
					value = "1";
				}
				: toggle {
					label = "Точки";
					key = "gp_prf_tchk3";
					value = "1";
				}
			}
		}
		: boxed_column {
			width = 46;
			: popup_list {
				key = "gp_prf_angle";
				label = "Графа углы поворота";
				value = "0";
				edit_width = 15;
				list = "Не выводить\nВыводить";
			}
			: edit_box {
				label = "Мин. угол поворота в гр.";
				key = "gp_prf_anglemin";
				is_enabled = false;
				edit_width = 12;
				}
		}
	}
	:row {
		: boxed_column {
			width = 46;
			: edit_box {
				label = "Условный горизонт";
				key = "gp_prf_ug";
				edit_width = 16;
			}
			: popup_list {
			label = " ";
				key = "gp_prf_ugt";
				value = "0";
				edit_width = 16;
				list = "Не подписывать\nПодписывать";
			}
		}
		:boxed_column {
			width = 46;
			: popup_list {
				label = "Масштаб горизонтальный 1 /";
				key = "gp_scale";
				edit_width = 8;
				list = "нет\n100\n200\n500\n1000\n2000\n5000\n10000\n20000\n50000";
			}
			: popup_list {
				label = "Масштаб вертикальный 1 /";
				mnemonic = "м";
				key = "gp_scale2";
				edit_width = 8;
				list = "нет\n10\n20\n50\n100\n200\n500\n1000\n2000\n5000";
			}
		}
	}
	:row {
		: boxed_column {
			width = 46;
			: toggle {
				label = "Рисовать линии шапки";
				key = "gp_prf_labs";
				value = "1";
			}
			: toggle {
				label = "Разные уровни разным цветом";
				key = "gp_prf_color";
				value = "1";
			}
		}
		: boxed_column {
			width = 46;
			: column {
				: row {
					: text {
						label = "Файл данных";
						width = 10;
					}
					: button {
						label = "Файл...";
						width = 20;
						mnemonic = "ф";
						key = "gp_file";
					}
				}
				: text {
					key = "gp_file_text";
					width = 20;
				}
			}
		}
	}
	: row {
		: spacer {width=1;}
		: button {
			label = "Да";
			key = "accept";
			width = 20;
			is_default = true;
		}
		: button {
			label = "Отмена";
			is_cancel = true;
			key = "cancel";
			width = 20;
			is_cancel = true;
		}
	}
}
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//Диалоговое окно "Откос"=========================================================================
otkos : dialog {
	: popup_list {
		label = "М 1 /";
		mnemonic = "м";
		key = "gp_scale";
		edit_width = 10;
		fixed_width = true;
		list = "нет\n100\n200\n500\n1000\n2000\n5000\n10000\n20000\n50000";
	}
	: row {
		: spacer {width=1;}
		: button {
			label = "Да";
			key = "accept";
			width = 8;
			is_default = true;
		}
		: button {
			label = "Отмена";
			is_cancel = true;
			key = "cancel";
			width = 8;
			is_cancel = true;
		}
	}
}
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//Диалоговое окно "Построение кривой"=============================================================
kriv : dialog {
	label = "Построение кривой";
	: edit_box {
		label = "Радиус  круговой  кривой";
		key = "gp_kr_R";
		edit_width = 5;
	}
	: edit_box {
		label = "Длина  переходной  кривой";
		key = "gp_kr_l";
		edit_width = 5;
	}
	: edit_box {
		label = "Длина  сегмента  кривой";
		key = "gp_kr_seg";
		edit_width = 5;
	}
	: edit_box {
		label = "Масштаб                                  1 /";
		mnemonic = "м";
		key = "gp_scale";
		edit_width = 5;
	}
	:row {
		: boxed_radio_row {
			label = "Название";
			fixed_width = true;
			: radio_button {
				label = "вкл";
				key = "gp_vntk_on";
				value = "1";
			}
			: radio_button {
				label = "выкл";
				key = "gp_vntk_off";
			}
		}
		: boxed_radio_row {
			label = "Координаты";
			fixed_width = true;
			: radio_button {
				label = "вкл";
				key = "gp_vcoor_on";
			}
			: radio_button {
				label = "выкл";
				key = "gp_vcoor_off";
				value = "1";
			}
		}
	}
	: boxed_row {
		: boxed_radio_row {
		label = "Точка";
			fixed_width = true;
			: radio_button {
				label = "вкл";
				key = "gp_vcircle_on";
				value = "1";
			}
			: radio_button {
				label = "выкл";
				key = "gp_vcircle_off";
			}
		}
		: edit_box {
			label = "Рад. мм";
			key = "gp_rad_circle";
			edit_width = 3;
		}
	}
	:boxed_row {
		label="Вывод данных";
		: boxed_radio_row {
			label = "Общие данные";
			fixed_width = true;
			: radio_button {
				label = "вкл";
				key = "gp_vdod_on";
			}
			: radio_button {
				label = "выкл";
				key = "gp_vdod_off";
				value = "1";
			}
		}
		: boxed_radio_row {
			label = "Пер. кривая";
			fixed_width = true;
			: radio_button {
				label = "вкл";
				key = "gp_vdpk_on";
			}
			: radio_button {
				label = "выкл";
				key = "gp_vdpk_off";
				value = "1";
			}
		}
	}

	: row {
		: spacer {width=1;}
		: button {
			label = "Да";
			key = "accept";
			width = 8;
			is_default = true;
		}
		: button {
			label = "Отмена";
			is_cancel = true;
			key = "cancel";
			width = 8;
			is_cancel = true;
		}
	}
}
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//Диалоговое окно "Штамп, условные знаки, примечания"=============================================
shtamp : dialog {
	label = "Штамп, условные знаки, примечания";
	: boxed_column {
			: toggle {
				label = "ПРИМЕЧАНИЯ";
				key = "gp_prim";
				value = "1";
			}
		: row {
			: toggle {
				key = "gp_pr1";
				value = "1";
			}
			: edit_box {
				key = "gp_prt1";
				edit_width = 80;
				fixed_width = true;
			}
		}
		: row {
			: toggle {
				key = "gp_pr2";
				value = "1";
			}
			: edit_box {
				key = "gp_prt2";
				edit_width = 80;
				fixed_width = true;
			}
		}
		: row {
			: toggle {
				key = "gp_pr3";
				value = "1";
			}
			: edit_box {
				key = "gp_prt3";
				edit_width = 80;
				fixed_width = true;
			}
		}
		: row {
			: toggle {
				key = "gp_pr4";
				value = "1";
			}
			: edit_box {
				key = "gp_prt4";
				edit_width = 80;
				fixed_width = true;
			}
		}
		: row {
			: toggle {
				key = "gp_pr5";
				value = "1";
			}
			: edit_box {
				key = "gp_prt5";
				edit_width = 80;
				fixed_width = true;
			}
		}
		: row {
			: toggle {
				key = "gp_pr6";
				value = "1";
			}
			: edit_box {
				key = "gp_prt6";
				edit_width = 80;
				fixed_width = true;
			}
		}
	}
	: boxed_row {
		: column {
			: boxed_row {
				: toggle {
					label = "УСЛОВНЫЕ ЗНАКИ";
					key = "gp_uszn";
					value = "1";
				}
			}
			: boxed_row {
				: column {
					: toggle {
						label = "Дорога";
						key = "gp_usdr";
						value = "1";
					}
					: toggle {
						label = "Водосток";
						key = "gp_usvs";
						value = "1";
					}
				}
			}
		}
		: boxed_row {
			: column {
				: toggle {
					label = "Водопровод";
					key = "gp_usvp";
					value = "1";
				}
				: toggle {
					label = "Канализация";
					key = "gp_uskn";
					value = "1";
				}
				: toggle {
					label = "Газопровод";
					key = "gp_usgz";
					value = "1";
				}
				: toggle {
					label = "Теплосеть";
					key = "gp_ustp";
					value = "1";
				}
			}
		}
		: boxed_row {
			: column {
				: toggle {
					label = "Электрокабель";
					key = "gp_usek";
					value = "1";
				}
				: toggle {
					label = "Кабель связи";
					key = "gp_usks";
					value = "1";
				}
				: toggle {
					label = "Полоса отвода";
					key = "gp_uspo";
					value = "1";
				}
				: toggle {
					label = "Геодезия";
					key = "gp_usgd";
					value = "1";
				}
			}
		}
	}
	: boxed_row {
		: column {
			: boxed_row {
				: toggle {
					label = "Ш Т А М П";
					key = "gp_shtamp";
					value = "1";
				}
			}
			: boxed_column {
				: popup_list {
					label = "Пред. кооп.";
					mnemonic = "о";
					key = "gp_fio1";
					edit_width = 15;
					fixed_width = true;
					list = "Животков А.В.";
				}
				: popup_list {
					label = "Геодезист ";
					mnemonic = "о";
					key = "gp_fio2";
					edit_width = 15;
					fixed_width = true;
					list = "Алборов Б.Г.\nБабин А.В.\nБорисов А.В.\nВеревкин С.И.\nЗаботин И.В.\nКазьмин И.С.\nКазьмин О.С.\nКвасов В.В.\nПудов Н.В.\nПудов С.В.\nРябов А.В.\nСафонов Д.А.\nСлесарев Д.Н.\nСоколов А.В.\nСтрогов А.В.\nТоготин А.А.\nЧермашенцев Ю.А.\nШелаев С.Ю.";
				}
				: popup_list {
					label = "Составил   ";
					mnemonic = "о";
					key = "gp_fio3";
					edit_width = 15;
					fixed_width = true;
					list = "Алборов Б.Г.\nБабин А.В.\nБорисов А.В.\nВеревкин С.И.\nЗаботин И.В.\nКазьмин И.С.\nКазьмин О.С.\nКоролева Л.Н.\nПудов Н.В.\nПудова М.А.\nРябов А.В.\nСафонов Д.А.\nСафонова Т.А.\nСлесарев Д.Н.\nСоколов А.В.\nСтрогов А.В.\nТоготин А.А.\nЧермашенцев Ю.А.\nЧернышова М.Э.\nШелаев С.Ю.";
				}
				: popup_list {
					label = "Проверил   ";
					mnemonic = "о";
					key = "gp_fio4";
					edit_width = 15;
					fixed_width = true;
				list = "Алборов Б.Г.\nБабин А.В.\nПудов С.В.\nРябов А.В.";
				}
			}
		}
		: boxed_column {
			: row {
				: edit_box {
					label = "Заказ  N";
					mnemonic = "з";
					key = "gp_zakaz";
					edit_width = 10;
					fixed_width = true;
				}
				: edit_box {
					label = "Код объекта";
					mnemonic = "к";
					key = "gp_kod";
					edit_width = 5;
					fixed_width = true;
				}		
			}	
			: boxed_column {
				label = "Объект";
				: edit_box {
					mnemonic = "о";
					key = "gp_ob1";
					edit_width = 40;
					fixed_width = true;
				}
				: edit_box {
					mnemonic = "о";
					key = "gp_ob2";
					edit_width = 40;
					fixed_width = true;
				}	
			}
			: row {
				: boxed_column {
					label = "Вид документа";
					: popup_list {
						mnemonic = "о";
						key = "gp_vid";
						edit_width = 25;
						fixed_width = true;
						list = "Схема выноса в натуру\nТопографический план\nСхема планового обоснования\nКорректировка плана местности\nРазбивочный чертеж\nКонструктивный чертеж\nПлан земляных масс\nСхема планового положения\n";
					}
					: edit_box {
						key = "gp_vid1";
						edit_width = 23;
						fixed_width = true;
					}
					: edit_box {
						key = "gp_vid2";
						edit_width = 23;
						fixed_width = true;
					}
				}
				: boxed_column {
					: edit_box {
						label = "Лист     ";
						mnemonic = "л";
						key = "gp_list";
						edit_width = 2;
						fixed_width = true;
					}
					: edit_box {
						label = "Листов";
						mnemonic = "л";
						key = "gp_lists";
						edit_width = 2;
						fixed_width = true;
					}
					: popup_list {
						label = "М 1 /";
						mnemonic = "м";
						key = "gp_scale";
						edit_width = 5;
						fixed_width = true;
						list = "нет\n100\n200\n500\n1000\n2000\n5000\n10000\n20000\n50000";
					}
				}
			}
		}
	}
	: row {
		: spacer {width=1;}
		: button {
			label = "Да";
			key = "accept";
			width = 35;
			is_default = true;
		}
		: button {
			label = "Отмена";
			is_cancel = true;
			key = "cancel";
			width = 35;
			is_cancel = true;
		}
	}
}
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//Диалоговое окно "Сколка координат"==============================================================
skolka : dialog {
	label = "Сколка координат";
	rumb_layer ;
//	spacer ;
//	spacer ;
	:row  {
		:boxed_column {
			label = "Элементы чертежа";
			: toggle {
				label = "Название";
				key = "gp_vnts";
				value = "1";
			}
			: toggle {
				label = "Линия";
				key = "gp_vline";
				value = "0";
			}
			: toggle {
				label = "Координаты";
				key = "gp_vcoor";
				value = "0";
			}
			: toggle {
				label = "Отметки";
				key = "gp_vh";
				value = "1";
			}
			: row {
				: toggle {
					label = "Точка";
					key = "gp_vcircle";
					value = "1";
				}
				: edit_box {
					label = "Рад. мм";
					key = "gp_rad_circle";
					fixed_width = true;
					edit_width = 2;
				}
			}
		}
		: column {
			: radio_column {
				label = "Система координат";
				: radio_button {
					label = "Мировая";
					key = "gp_rb_coorw";
				}
				: radio_button {
					label = "Геодезическая";
					key = "gp_rb_coorg";
				}
			}
	spacer ;
	spacer ;
	spacer ;
		rumb_scale ;
	spacer ;
	spacer ;
		}
	}
	: boxed_column {
		label = "Файл сколки";
		width = 50;
//		fixed_width = true;
		: row {
			: popup_list {
				key = "gp_vfile";
				value = "1";
				fixed_width = true;
				edit_width = 30;
				list = "Без записи в файл\nЗапись в файл \nЗапись в файл с отметкой\nЗапись в файл с 2-мя отметками\nЗапись в файл с 3-мя отметками";
			}
			: button {
				label = "Файл...";
				fixed_width = true;
				mnemonic = "ф";
				key = "gp_file";
			}
		}
		spacer ;
		: text {
			key = "gp_file_text";
		}
	}
	: row {
		: spacer {width=1;}
		: button {
			label = "Да";
			key = "accept";
			width = 8;
			is_default = true;
		}
		: button {
			label = "Отмена";
			is_cancel = true;
			key = "cancel";
			width = 8;
			is_cancel = true;
		}
	}
}
