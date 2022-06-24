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
//������� "����"==================================================================================
rumb_layer : boxed_row {
			label = "����";
			width = 50;
			fixed_width = true;
			: popup_list {
				key = "gpr_pl_lay";
				edit_width = 15;
				value = "1";
			}
			spacer;
			: toggle {
				label = "�����";
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
//������� "�������"===============================================================================
rumb_scale : popup_list {
		label = "�������";
		key = "gp_scale";
		edit_width = 8;
		list = "���\n1/100\n1/200\n1/500\n1/1000\n1/2000\n1/5000\n1/10000\n1/20000\n1/50000";
}
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//���������� ���� "�������"=======================================================================
profil : dialog {
	label = "��������� �������";
	rumb_layer;
	:row {
		: boxed_radio_row {
			label = "1-�� ����� �������";
			width = 46;
			: column {
				: popup_list {
					key = "gp_prf_otm1";
					value = "1";
					edit_width = 15;
					fixed_width = true;
					list = "�� �����������\n�� ������\n��� ������";
				}
				: toggle {
					label = "�������������� �����";
					key = "gp_prf_sline1";
					value = "1";
				}
			}
			: column {
				: toggle {
					label = "��������";
					key = "gp_prf_ord1";
					value = "1";
				}
				: toggle {
					label = "�����";
					key = "gp_prf_tchk1";
					value = "1";
				}
			}
		}
		: boxed_column {
			width = 46;
			: popup_list {
				label = "����� ����������        ";
				key = "gp_prf_ras";
				value = "0";
				edit_width = 15;
				list = "�� ��������\n��������";
			}
			: popup_list {
				label = "�������� �����������";
				key = "gp_prf_namegv";
				edit_width = 15;
				value = "1";
				list = "�� �����������\n�������������\n�����������";
			}
		}
	}
	: row {
		: boxed_radio_row {
			label = "2-�� ����� �������";
			width = 46;
			: column {
				: popup_list {
					key = "gp_prf_otm2";
					value = "1";
					edit_width = 15;
					fixed_width = true;
					list = "�� �����������\n�� ������\n��� ������";
				}
				: toggle {
					label = "�������������� �����";
					key = "gp_prf_sline2";
					value = "1";
				}
			}
			: column {
				: toggle {
					label = "��������";
					key = "gp_prf_ord2";
					value = "1";
				}
				: toggle {
					label = "�����";
					key = "gp_prf_tchk2";
					value = "1";
				}
			}
		}
		: boxed_radio_column {
			width = 46;
			: popup_list{
				label = "����� ������";
				key = "gp_prf_ukl";
				edit_width = 15;
				list = "�� ��������\n�� 1-�� ������\n�� 2-�� ������\n�� 3-�� ������";
			}
			: popup_list {
				label = "�����������            ";
				key = "gp_prf_uklr";
				edit_width = 15;
				list = "*1\n*10\n*100\n*1000";
			}
		}
	}
	: row {
		: boxed_radio_row {
			label = "3-� ����� �������";
			width = 46;
			: column {
				: popup_list {
					key = "gp_prf_otm3";
					value = "1";
					edit_width = 15;
					fixed_width = true;
					list = "�� �����������\n�� ������\n��� ������";
				}
				: toggle {
					label = "�������������� �����";
					key = "gp_prf_sline3";
					value = "1";
				}
			}
			: column {
				: toggle {
					label = "��������";
					key = "gp_prf_ord3";
					value = "1";
				}
				: toggle {
					label = "�����";
					key = "gp_prf_tchk3";
					value = "1";
				}
			}
		}
		: boxed_column {
			width = 46;
			: popup_list {
				key = "gp_prf_angle";
				label = "����� ���� ��������";
				value = "0";
				edit_width = 15;
				list = "�� ��������\n��������";
			}
			: edit_box {
				label = "���. ���� �������� � ��.";
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
				label = "�������� ��������";
				key = "gp_prf_ug";
				edit_width = 16;
			}
			: popup_list {
			label = " ";
				key = "gp_prf_ugt";
				value = "0";
				edit_width = 16;
				list = "�� �����������\n�����������";
			}
		}
		:boxed_column {
			width = 46;
			: popup_list {
				label = "������� �������������� 1 /";
				key = "gp_scale";
				edit_width = 8;
				list = "���\n100\n200\n500\n1000\n2000\n5000\n10000\n20000\n50000";
			}
			: popup_list {
				label = "������� ������������ 1 /";
				mnemonic = "�";
				key = "gp_scale2";
				edit_width = 8;
				list = "���\n10\n20\n50\n100\n200\n500\n1000\n2000\n5000";
			}
		}
	}
	:row {
		: boxed_column {
			width = 46;
			: toggle {
				label = "�������� ����� �����";
				key = "gp_prf_labs";
				value = "1";
			}
			: toggle {
				label = "������ ������ ������ ������";
				key = "gp_prf_color";
				value = "1";
			}
		}
		: boxed_column {
			width = 46;
			: column {
				: row {
					: text {
						label = "���� ������";
						width = 10;
					}
					: button {
						label = "����...";
						width = 20;
						mnemonic = "�";
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
			label = "��";
			key = "accept";
			width = 20;
			is_default = true;
		}
		: button {
			label = "������";
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
//���������� ���� "�����"=========================================================================
otkos : dialog {
	: popup_list {
		label = "� 1 /";
		mnemonic = "�";
		key = "gp_scale";
		edit_width = 10;
		fixed_width = true;
		list = "���\n100\n200\n500\n1000\n2000\n5000\n10000\n20000\n50000";
	}
	: row {
		: spacer {width=1;}
		: button {
			label = "��";
			key = "accept";
			width = 8;
			is_default = true;
		}
		: button {
			label = "������";
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
//���������� ���� "���������� ������"=============================================================
kriv : dialog {
	label = "���������� ������";
	: edit_box {
		label = "������  ��������  ������";
		key = "gp_kr_R";
		edit_width = 5;
	}
	: edit_box {
		label = "�����  ����������  ������";
		key = "gp_kr_l";
		edit_width = 5;
	}
	: edit_box {
		label = "�����  ��������  ������";
		key = "gp_kr_seg";
		edit_width = 5;
	}
	: edit_box {
		label = "�������                                  1 /";
		mnemonic = "�";
		key = "gp_scale";
		edit_width = 5;
	}
	:row {
		: boxed_radio_row {
			label = "��������";
			fixed_width = true;
			: radio_button {
				label = "���";
				key = "gp_vntk_on";
				value = "1";
			}
			: radio_button {
				label = "����";
				key = "gp_vntk_off";
			}
		}
		: boxed_radio_row {
			label = "����������";
			fixed_width = true;
			: radio_button {
				label = "���";
				key = "gp_vcoor_on";
			}
			: radio_button {
				label = "����";
				key = "gp_vcoor_off";
				value = "1";
			}
		}
	}
	: boxed_row {
		: boxed_radio_row {
		label = "�����";
			fixed_width = true;
			: radio_button {
				label = "���";
				key = "gp_vcircle_on";
				value = "1";
			}
			: radio_button {
				label = "����";
				key = "gp_vcircle_off";
			}
		}
		: edit_box {
			label = "���. ��";
			key = "gp_rad_circle";
			edit_width = 3;
		}
	}
	:boxed_row {
		label="����� ������";
		: boxed_radio_row {
			label = "����� ������";
			fixed_width = true;
			: radio_button {
				label = "���";
				key = "gp_vdod_on";
			}
			: radio_button {
				label = "����";
				key = "gp_vdod_off";
				value = "1";
			}
		}
		: boxed_radio_row {
			label = "���. ������";
			fixed_width = true;
			: radio_button {
				label = "���";
				key = "gp_vdpk_on";
			}
			: radio_button {
				label = "����";
				key = "gp_vdpk_off";
				value = "1";
			}
		}
	}

	: row {
		: spacer {width=1;}
		: button {
			label = "��";
			key = "accept";
			width = 8;
			is_default = true;
		}
		: button {
			label = "������";
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
//���������� ���� "�����, �������� �����, ����������"=============================================
shtamp : dialog {
	label = "�����, �������� �����, ����������";
	: boxed_column {
			: toggle {
				label = "����������";
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
					label = "�������� �����";
					key = "gp_uszn";
					value = "1";
				}
			}
			: boxed_row {
				: column {
					: toggle {
						label = "������";
						key = "gp_usdr";
						value = "1";
					}
					: toggle {
						label = "��������";
						key = "gp_usvs";
						value = "1";
					}
				}
			}
		}
		: boxed_row {
			: column {
				: toggle {
					label = "����������";
					key = "gp_usvp";
					value = "1";
				}
				: toggle {
					label = "�����������";
					key = "gp_uskn";
					value = "1";
				}
				: toggle {
					label = "����������";
					key = "gp_usgz";
					value = "1";
				}
				: toggle {
					label = "���������";
					key = "gp_ustp";
					value = "1";
				}
			}
		}
		: boxed_row {
			: column {
				: toggle {
					label = "�������������";
					key = "gp_usek";
					value = "1";
				}
				: toggle {
					label = "������ �����";
					key = "gp_usks";
					value = "1";
				}
				: toggle {
					label = "������ ������";
					key = "gp_uspo";
					value = "1";
				}
				: toggle {
					label = "��������";
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
					label = "� � � � �";
					key = "gp_shtamp";
					value = "1";
				}
			}
			: boxed_column {
				: popup_list {
					label = "����. ����.";
					mnemonic = "�";
					key = "gp_fio1";
					edit_width = 15;
					fixed_width = true;
					list = "�������� �.�.";
				}
				: popup_list {
					label = "��������� ";
					mnemonic = "�";
					key = "gp_fio2";
					edit_width = 15;
					fixed_width = true;
					list = "������� �.�.\n����� �.�.\n������� �.�.\n�������� �.�.\n������� �.�.\n������� �.�.\n������� �.�.\n������ �.�.\n����� �.�.\n����� �.�.\n����� �.�.\n������� �.�.\n�������� �.�.\n������� �.�.\n������� �.�.\n������� �.�.\n����������� �.�.\n������ �.�.";
				}
				: popup_list {
					label = "��������   ";
					mnemonic = "�";
					key = "gp_fio3";
					edit_width = 15;
					fixed_width = true;
					list = "������� �.�.\n����� �.�.\n������� �.�.\n�������� �.�.\n������� �.�.\n������� �.�.\n������� �.�.\n�������� �.�.\n����� �.�.\n������ �.�.\n����� �.�.\n������� �.�.\n�������� �.�.\n�������� �.�.\n������� �.�.\n������� �.�.\n������� �.�.\n����������� �.�.\n��������� �.�.\n������ �.�.";
				}
				: popup_list {
					label = "��������   ";
					mnemonic = "�";
					key = "gp_fio4";
					edit_width = 15;
					fixed_width = true;
				list = "������� �.�.\n����� �.�.\n����� �.�.\n����� �.�.";
				}
			}
		}
		: boxed_column {
			: row {
				: edit_box {
					label = "�����  N";
					mnemonic = "�";
					key = "gp_zakaz";
					edit_width = 10;
					fixed_width = true;
				}
				: edit_box {
					label = "��� �������";
					mnemonic = "�";
					key = "gp_kod";
					edit_width = 5;
					fixed_width = true;
				}		
			}	
			: boxed_column {
				label = "������";
				: edit_box {
					mnemonic = "�";
					key = "gp_ob1";
					edit_width = 40;
					fixed_width = true;
				}
				: edit_box {
					mnemonic = "�";
					key = "gp_ob2";
					edit_width = 40;
					fixed_width = true;
				}	
			}
			: row {
				: boxed_column {
					label = "��� ���������";
					: popup_list {
						mnemonic = "�";
						key = "gp_vid";
						edit_width = 25;
						fixed_width = true;
						list = "����� ������ � ������\n��������������� ����\n����� ��������� �����������\n������������� ����� ���������\n����������� ������\n�������������� ������\n���� �������� ����\n����� ��������� ���������\n";
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
						label = "����     ";
						mnemonic = "�";
						key = "gp_list";
						edit_width = 2;
						fixed_width = true;
					}
					: edit_box {
						label = "������";
						mnemonic = "�";
						key = "gp_lists";
						edit_width = 2;
						fixed_width = true;
					}
					: popup_list {
						label = "� 1 /";
						mnemonic = "�";
						key = "gp_scale";
						edit_width = 5;
						fixed_width = true;
						list = "���\n100\n200\n500\n1000\n2000\n5000\n10000\n20000\n50000";
					}
				}
			}
		}
	}
	: row {
		: spacer {width=1;}
		: button {
			label = "��";
			key = "accept";
			width = 35;
			is_default = true;
		}
		: button {
			label = "������";
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
//���������� ���� "������ ���������"==============================================================
skolka : dialog {
	label = "������ ���������";
	rumb_layer ;
//	spacer ;
//	spacer ;
	:row  {
		:boxed_column {
			label = "�������� �������";
			: toggle {
				label = "��������";
				key = "gp_vnts";
				value = "1";
			}
			: toggle {
				label = "�����";
				key = "gp_vline";
				value = "0";
			}
			: toggle {
				label = "����������";
				key = "gp_vcoor";
				value = "0";
			}
			: toggle {
				label = "�������";
				key = "gp_vh";
				value = "1";
			}
			: row {
				: toggle {
					label = "�����";
					key = "gp_vcircle";
					value = "1";
				}
				: edit_box {
					label = "���. ��";
					key = "gp_rad_circle";
					fixed_width = true;
					edit_width = 2;
				}
			}
		}
		: column {
			: radio_column {
				label = "������� ���������";
				: radio_button {
					label = "�������";
					key = "gp_rb_coorw";
				}
				: radio_button {
					label = "�������������";
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
		label = "���� ������";
		width = 50;
//		fixed_width = true;
		: row {
			: popup_list {
				key = "gp_vfile";
				value = "1";
				fixed_width = true;
				edit_width = 30;
				list = "��� ������ � ����\n������ � ���� \n������ � ���� � ��������\n������ � ���� � 2-�� ���������\n������ � ���� � 3-�� ���������";
			}
			: button {
				label = "����...";
				fixed_width = true;
				mnemonic = "�";
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
			label = "��";
			key = "accept";
			width = 8;
			is_default = true;
		}
		: button {
			label = "������";
			is_cancel = true;
			key = "cancel";
			width = 8;
			is_cancel = true;
		}
	}
}
