OBJS = \
	gemstart.o \
	bcmp.o \
	bcopy.o \
	bzero.o \
	crash.o \
	ffs.o \
	term.o \
	alloca.o \
	gembios.o \
	gemxbios.o \
	gemlinea.o \
	index.o \
	plot.o \
	port.o \
	queue.o \
	random.o \
	readv.o \
	select.o \
	socket.o \
	\
	vdi.o \
	v_arc.o \
	v_bar.o \
	v_bit_image.o \
	v_cellarray.o \
	v_circle.o \
	v_cl_dsp_lst.o \
	v_clrwk.o \
	v_clsvwk.o \
	v_clswk.o \
	v_contourfl.o \
	v_curdown.o \
	v_curhome.o \
	v_curleft.o \
	v_curright.o \
	v_curtext.o \
	v_curup.o \
	v_dspcur.o \
	v_eeol.o \
	v_eeos.o \
	v_ellarc.o \
	v_ellipse.o \
	v_ellpie.o \
	v_enter_cur.o \
	v_exit_cur.o \
	v_fillarea.o \
	v_form_adv.o \
	v_get_pixel.o \
	v_gtext.o \
	v_hardcopy.o \
	v_hide_c.o \
	v_justified.o \
	v_meta_ext.o \
	v_opnvwk.o \
	v_opnwk.o \
	v_output_wnd.o \
	v_pieslice.o \
	v_pline.o \
	v_pmarker.o \
	v_rbox.o \
	v_rfbox.o \
	v_rmcur.o \
	v_rvoff.o \
	v_rvon.o \
	v_show_c.o \
	v_updwk.o \
	v_write_meta.o \
	vex_butv.o \
	vex_curv.o \
	vex_motv.o \
	vex_timv.o \
	vm_filename.o \
	vq_cellarray.o \
	vq_chcells.o \
	vq_color.o \
	vq_curaddr.o \
	vq_extnd.o \
	vq_key_s.o \
	vq_mouse.o \
	vq_tabstatus.o \
	vqf_attrib.o \
	vqin_mode.o \
	vql_attrib.o \
	vqm_attrib.o \
	vqp_error.o \
	vqp_films.o \
	vqp_state.o \
	vqt_attrib.o \
	vqt_extent.o \
	vqt_fnt_info.o \
	vqt_name.o \
	vqt_width.o \
	vr_recfl.o \
	vr_trnfm.o \
	vro_cpyfm.o \
	vrq_choice.o \
	vrq_locator.o \
	vrq_valuator.o \
	vrq_string.o \
	vrt_cpyfm.o \
	vs_clip.o \
	vs_color.o \
	vs_curaddr.o \
	vs_palette.o \
	vsc_form.o \
	vsf_color.o \
	vsf_interior.o \
	vsf_perim.o \
	vsf_style.o \
	vsf_udpat.o \
	vsin_mode.o \
	vsl_color.o \
	vsl_ends.o \
	vsl_type.o \
	vsl_udsty.o \
	vsl_width.o \
	vsm_choice.o \
	vsm_color.o \
	vsm_height.o \
	vsm_locator.o \
	vsm_string.o \
	vsm_type.o \
	vsm_valuator.o \
	vsp_message.o \
	vsp_save.o \
	vsp_state.o \
	vst_align.o \
	vst_color.o \
	vst_effects.o \
	vst_font.o \
	vst_height.o \
	vst_ld_fnts.o \
	vst_point.o \
	vst_rotation.o \
	vst_ul_fnts.o \
	vswr_mode.o \
	$(empty)

CROSS=m68k-atari-mint-
CC = $(CROSS)gcc
AS = $(CROSS)as
AR = $(CROSS)ar

CFLAGS = -Os \
	-I. -I../linux -nostdinc -fno-builtin -D_PROTO=1 \
	-Wstrict-prototypes -Wmissing-prototypes -Wall -W -Werror

all: libgem.o

libgem.o: $(OBJS)
	rm -f $@
	$(AR) rcs $@ $(OBJS)

clean:
	rm -f *.o
