#ifndef __GEMBIND__
#define __GEMBIND__ 1

/*	set up prototyping
 */
#ifndef __
#ifdef _PROTO
#define __(a)	a
#else
#define __(a)	()
#endif
#endif

int Get_Handle __((short *x_width, short *x_height, short *max_colors));
void Close_Handle __((void));

int Save_Term __((int fd));
void Restore_Term __((int fd, int mode));
void Raw_On __((int fd));
void Raw_Off __((int fd));
void Echo_On __((int fd));
void Echo_Off __((int fd));

#ifndef TOS
int Bconstat __((int fd));
int Bconin __((int fd));
void Bconout __((int fd, int c));
#endif

#ifndef TOS
/* For running under 'Idris' redefine the following VDI and LINE-A */
/* calls so that they will fail to link correctly!!!!!!!!!!!!!!!!! */
/* these won't work under 'Idris' and may just blow it up!!!!!!!!! */

#define v_opnvwk     _v_opnvwk
#define v_clsvwk     _v_clsvwk
#define vq_mouse     _vq_mouse
#define vq_key_s     _vq_key_s
#define vst_load_fonts  _vst_load_fonts
#define vst_unload_fonts  _vst_unload_fonts
#define vsin_mode    _vsin_mode
#define vrq_locator  _vrq_locator
#define vsm_locator  _vsm_locator
#define vrq_valuator _vrq_valuator
#define vsm_valuator _vsm_valuator
#define vrq_choice   _vrq_choice
#define vsm_choice   _vsm_choice
#define vrq_string   _vrq_string
#define vsm_string   _vsm_string
#define vex_timv     _vex_timv
#define vex_butv     _vex_butv
#define vex_motv     _vex_motv
#define vex_curv     _vex_curv
#define vqin_mode    _vqin_mode
#define vq_tabstatus _vq_tabstatus
#define v_hardcopy   _v_hardcopy
#define v_form_adv   _v_form_adv
#define v_output_window _v_output_window
#define v_clear_disp_list _v_clear_disp_list
#define v_bit_image  _v_bit_image
#define vs_pallette  _vs_pallette
#define vqp_films    _vqp_films
#define vqp_state    _vqp_state
#define vsp_state    _vsp_state
#define vsp_save     _vsp_save
#define vsp_message  _vsp_message
#define vqp_error    _vqp_error
#define v_meta_extents   _v_meta_extents
#define v_write_meta _v_write_meta
#define vm_filename  _vm_filename
#define Asmouse      _Asmouse
#define Ahmouse      _Ahmouse
#define Atmouse      _Atmouse
#endif

/* ------------------------- start of line-a stuff ------------------------ */

/* structure for interfacing to line-a traps */
struct LINE_A
    {
    short vplanes   ; /* (0x00) */
    short vwrap     ; /* (0x02) */
    short *con_trl  ; /* (0x04) */
    short *int_in   ; /* (0x08) */
    short *pts_in   ; /* (0x0c) */
    short *int_out  ; /* (0x10) */
    short *pts_out  ; /* (0x14) */
    short col0bit   ; /* (0x18) */
    short col1bit   ; /* (0x1a) */
    short col2bit   ; /* (0x1c) */
    short col3bit   ; /* (0x1e) */
    short lstlin    ; /* (0x20) */
    short lnmask    ; /* (0x22) */
    short wmode     ; /* (0x24) */
    short x1        ; /* (0x26) x1 coordinate                   */
    short y1        ; /* (0x28) y1 coordinate                   */
    short x2        ; /* (0x2a) x2 coordinate                   */
    short y2        ; /* (0x2c) y2 coordinate                   */
    long  patptr    ; /* (0x2e) ptr to the current fill pattern */
    short patmsk    ; /* (0x32) */
    short mfill     ; /* (0x34) */
    short clip      ; /* (0x36) */
    short xmincl    ; /* (0x38) */
    short ymincl    ; /* (0x3a) */
    short xmaxcl    ; /* (0x3c) */
    short ymaxcl    ; /* (0x3e) */
    short xdda      ; /* (0x40) */
    short ddainc    ; /* (0x42) */
    short scaldir   ; /* (0x44) */
    short mono      ; /* (0x46) */
    short xsource   ; /* (0x48) x coord of character in font form           */
    short ysource   ; /* (0x4a) x coord of character in font form           */
    short xdest     ; /* (0x4c) x coord of character on screen              */
    short ydest     ; /* (0x4e) y coord of character on screen              */
    short xdel      ; /* (0x50) width  of a character                       */
    short ydel      ; /* (0x52) height of a character                       */
    long  fbase     ; /* (0x54) ptr to start of font data (font form)       */
    short fwidth    ; /* (0x58) width of the font form                      */
    short style     ; /* (0x5a) vector of TextBlt special effects flags     */
    short litemask  ; /* (0x5c) the mask to use in lightening the text      */
    short skewmask  ; /* (0x5e) the mask to use in skewing the text         */
    short weight    ; /* (0x60) the width by which to thicken text          */
    short roff      ; /* (0x62) offset above char baseline when skewing     */
    short loff      ; /* (0x64) offset below char baseline when skewing     */
    short scale     ; /* (0x66) scaling flag (0 => no scaling)              */
    short chup      ; /* (0x68) character rotation vector                   */
    short textfg    ; /* (0x6a) text foreground color                       */
    long  scrtchp   ; /* (0x6c) ptr to start of text special effects buffer */
    short scrpt2    ; /* (0x70) offset of scaling buffer in above buffer    */
    short textbc    ; /* (0x72) text background color                       */
    short copytran  ; /* (0x74) copy raster form type flag                  */
    long  seedabort ; /* (0x76) ptr to seedfill abort test rountine         */
    } ;

typedef struct _sprite
    {
    short xhot      ;
    short yhot      ;
    short format    ;
    short c_back    ;
    short c_fore    ;
    short image[32] ;
    } SPRITE        ;

/* this structure assumes compiler won't try to long align the longs! */
typedef struct _blt_tab
    {
    /* -------------------------------------------------------------- */
    short blt_width  ;  /* (00) width in pixels  to transfer          */
    short blt_height ;  /* (02) height in pixesl to transfer          */
    short blt_planes ;  /* (04) number of planes to transfer          */
    short fore_color ;  /* (06) foreground color to set               */
    short back_color ;  /* (08) background color to set               */
    char  op0        ;  /* (10) logic operation entry 0               */
    char  op1        ;  /* (11) logic operation entry 1               */
    char  op2        ;  /* (12) logic operation entry 2               */
    char  op3        ;  /* (13) logic operation entry 3               */
    /* -------------------------------------------------------------- */
    short src_xmin   ;  /* (14) minimum source x value                */
    short src_ymin   ;  /* (16) minimum source y value                */
    long  src_addr   ;  /* (18) base address of source planes         */
    short src_nxtwrd ;  /* (22) number of bytes to next word in line  */
    short src_nxtlin ;  /* (24) number of bytes to next line in plane */
    short src_nxtpln ;  /* (26) number of bytes to next plane         */
    /* -------------------------------------------------------------- */
    short dst_xmin   ;  /* (28) minimum destination x value           */
    short dst_ymin   ;  /* (30) minimum destination y value           */
    long  dst_addr   ;  /* (32) base address of destination planes    */
    short dst_nxtwrd ;  /* (36) number of bytes to next word in line  */
    short dst_nxtlin ;  /* (38) number of bytes to next line in plane */
    short dst_nxtpln ;  /* (40) number of bytes to next plane         */
    /* -------------------------------------------------------------- */
    long  pat_addr   ;  /* (42) pattern buffer address                */
    short pat_nxtlin ;  /* (46) number of bytes to next line in pat.  */
    short pat_nxtpln ;  /* (48) number of bytes to next plane         */
    short pat_mask   ;  /* (50) computed pattern length mask          */
    /* -------------------------------------------------------------- */
    long  dummy0     ;  /* (52) pad to make 76 bytes long             */
    long  dummy1     ;  /* (56) pad to make 76 bytes long             */
    long  dummy2     ;  /* (60) pad to make 76 bytes long             */
    long  dummy3     ;  /* (64) pad to make 76 bytes long             */
    long  dummy4     ;  /* (68) pad to make 76 bytes long             */
    long  dummy5     ;  /* (72) pad to make 76 bytes long             */
    /* -------------------------------------------------------------- */
    } BLT_TAB ;

typedef struct {
	short ssb[10 + 4 * 64];
} SSB;

struct LINE_A *Ainit __((void));
void Appixel __((void));
int Agpixel __((void));
void Aline __((void));
void Ahline __((void));
void Afrect __((void));
void Afpoly __((void));
void Abitblt __((BLT_TAB *blt));
void Atxtblt __((void));
void Asmouse __((void)); /* show mouse */
void Ahmouse __((void)); /* hide mouse */
void Atmouse __((void)); /* transform mouse */
void Ausprit __((SSB *ssb)); /* undraw sprite */
void Adsprit __((short x, short y, SSB *ssb, SPRITE *sprite)); /* draw sprite */
void Acraste __((void));
void Aseedfi __((void));
void **Aversio __((void));


/* ======================================================================== */
/*                         VDI interface definitions                        */
/* ======================================================================== */

#ifndef TRUE
#define TRUE    1
#endif

#ifndef FALSE
#define FALSE   0
#endif

#define MAX_CMAPS 16 /* max colormap size */

/* default color map index */
#define WHITE          0
#define RED            1
#define GREEN          2
#define YELLOW         3
#define BLUE           4
#define MAGENTA        5
#define CYAN           6
#define LOW_WHITE      7
#define GREY           8
#define LIGHT_RED      9
#define LIGHT_GREEN   10
#define LIGHT_YELLOW  11
#define LIGHT_BLUE    12
#define LIGHT_MAGENTA 13
#define LIGHT_CYAN    14
#define BLACK         15

#define INVISIBLE 0
#define   VISIBLE 1

/* ------------------ line types -------------------- */
#define SOLID           1
#define LONGDASH        2
#define DOT             3
#define DASHDOT         4
#define DASH            5
#define DASH2DOT        6
#define USERLINE        7

#define MD_REPLACE      1
#define MD_TRANS        2
#define MD_XOR          3
#define MD_ERASE        4

/* bit blt rules */
#define ALL_WHITE		0
#define S_AND_D			1
#define S_AND_NOTD		2
#define S_ONLY			3
#define NOTS_AND_D		4
#define D_ONLY			5
#define S_XOR_D			6
#define S_OR_D			7
#define NOT_SORD		8
#define NOT_SXORD		9
#define D_INVERT		10
#define NOT_D			10
#define S_OR_NOTD		11
#define NOT_S			12
#define NOTS_OR_D		13
#define NOT_SANDD		14
#define ALL_BLACK		15

/* structure needed by vdi form calls */
#ifndef __MFDB__
#define __MFDB__
typedef struct MEM_FORM {
    void *fd_addr;
    short fd_w;
    short fd_h;
    short fd_wdwidth;
    short fd_stand;
    short fd_nplanes;
    short fd_r1;
    short fd_r2;
    short fd_r3;
} MFDB;
#endif

typedef struct {
	short *contrl;
	short *intin;
	short *ptsin;
	short *intout;
	short *ptsout;
} VDIPB;

extern short contrl[];
extern short intin[];
extern short ptsin[];
extern short intout[];
extern short ptsout[];

extern VDIPB vdipb;
void vdi(void);

void v_arc(short handle, short x, short y, short radius, short begang, short endang);
void v_bar(short handle, short *pxyarray);
void v_circle(short handle, short x, short y, short radius);
#if 0 /* BUGGY */
void v_bit_image(short handle, const char *filename, short aspect, short x_scale, short y_scale, short *xyarray);
#else
void v_bit_image(short handle, const char *filename, short aspect, short x_scale, short y_scale, short h_align, short v_align, short *xyarray);
#endif
void v_cellarray(short handle, short *pxyarray, short row_length, short el_used, short num_rows, short wrt_mode, short *colarray);
void v_clear_disp_list(short handle);
void v_clrwk(short handle);
void v_clswk(short handle);
void v_clsvwk(short handle);
void v_contourfill(short handle, short x, short y, short index);
void v_curdown(short handle);
void v_curhome(short handle);
void v_curleft(short handle);
void v_curright(short handle);
void v_curtext(short handle, const char *string);
void v_curup(short handle);
void v_dspcur(short handle, short x, short y);
void v_eeol(short handle);
void v_eeos(short handle);
void v_ellarc(short handle, short x, short y, short xradius, short yradius, short begang, short endang);
void v_ellipse(short handle, short x, short y, short xradius, short yradius);
void v_ellpie(short handle, short x, short y, short xradius, short yradius, short begang, short endang);
void v_enter_cur(short handle);
void v_exit_cur(short handle);
void v_fillarea(short handle, short count, short *pxyarray);
void v_form_adv(short handle);
void v_get_pixel(short handle, short x, short y, short *pel, short *index);
void v_gtext(short handle, short x, short y, const char *string);
void v_hardcopy(short handle);
void v_hide_c(short handle);
void v_justified(short handle, short x, short y, const char *string, short length, short word_space, short char_space);
void v_meta_extents(short handle, short min_x, short min_y, short max_x, short max_y);
void v_opnvwk(short *work_in, short *handle, short *work_out);
void v_opnwk(short *work_in, short *handle, short *work_out);
void v_output_window(short handle, short *pxyarray);
void v_pieslice(short handle, short x, short y, short radius, short begang, short endang);
void v_pline(short handle, short count, short *pxyarray);
void v_pmarker(short handle, short count, short *pxyarray);
void v_rbox(short handle, short *pxyarray);
void v_rfbox(short handle, short *pxyarray);
void v_rmcur(short handle);
void v_rvoff(short handle);
void v_rvon(short handle);
void v_show_c(short handle, short reset);
void v_updwk(short handle);
void v_write_meta(short handle, short num_intin, short *a_intin, short num_ptsin, short *a_ptsin);
void vex_butv(short handle, void (*pusrcode)(void), void (**psavcode)(void));
void vex_curv(short handle, void (*pusrcode)(void), void (**psavcode)(void));
void vex_motv(short handle, void (*pusrcode)(void), void (**psavcode)(void));
void vex_timv(short handle, void (*tim_addr)(void), void (**otim_addr)(void), short *tim_conv);
void vm_filename(short handle, const char *filename);
void vq_cellarray(short handle, short *pxyarray, short row_length, short num_rows, short *el_used, short *rows_used, short *status, short *colarray);
void vq_chcells(short handle, short *rows, short *columns);
short vq_color(short handle, short color_index, short set_flag, short *rgb);
void vq_curaddress(short handle, short *row, short *column);
void vq_extnd(short handle, short owflag, short *work_out);
void vq_key_s(short handle, short *pstatus);
void vq_mouse(short handle, short *pstatus, short *x, short *y);
short vq_tabstatus(short handle);
void vqf_attributes(short handle, short *attrib);
void vqin_mode(short handle, short dev_type, short *input_mode);
void vql_attributes(short handle, short *attrib);
void vqm_attributes(short handle, short *attrib);
short vqp_error(short handle);
void vqp_films(short handle, char *film_names);
void vqp_state(short handle, short *port, short *lightness, short *interlace, short *planes, short *indexes, char *film_name);
void vqt_attributes(short handle, short *attrib);
void vqt_extent(short handle, const char *string, short *extent);
void vqt_fontinfo(short handle, short *minADE, short *maxADE, short *distances, short *maxwidth, short *effects);
short vqt_name(short handle, short element_num, char *name);
short vqt_width(short handle, unsigned char character, short *cell_width, short *left_delta, short *right_delta);
void vr_recfl(short handle, short *pxyarray);
void vr_trnfm(short handle, MFDB *psrcMFDB, MFDB *pdesMFDB);
void vro_cpyfm(short handle, short vr_mode, short *pxyarray, MFDB *psrcMFDB, MFDB *pdesMFDB);
void vrq_choice(short handle, short ch_in, short *ch_out);
void vrq_locator(short handle, short x, short y, short *xout, short *yout, short *term);
void vrq_string(short handle, short max_length, short echo_mode, short *echo_xy, char *string);
void vrq_valuator(short handle, short valuator_in, short *valuator_out, short *terminator);
void vrt_cpyfm(short handle, short vr_mode, short *pxyarray, MFDB *psrcMFDB, MFDB *pdesMFDB, short *color_index);
void vs_clip(short handle, short clip_flag, short *pxyarray);
void vs_color(short handle, short index, short *rgb_in);
void vs_curaddress(short handle, short row, short column);
short vs_palette(short handle, short palette);
void vsc_form(short handle, short *pcur_form);
short vsf_color(short handle, short color_index);
short vsf_interior(short handle, short style);
short vsf_perimeter(short handle, short per_vis);
short vsf_style(short handle, short style_index);
void vsf_udpat(short handle, short *pfill_pat, short planes);
short vsin_mode(short handle, short dev_type, short mode);
short vsl_color(short handle, short color_index);
void vsl_ends(short handle, short beg_style, short end_style);
short vsl_type(short handle, short style);
void vsl_udsty(short handle, short pattern);
short vsl_width(short handle, short width);
short vsm_choice(short handle, short *choice);
short vsm_color(short handle, short color_index);
short vsm_height(short handle, short height);
short vsm_locator(short handle, short x, short y, short *xout, short *yout, short *term);
short vsm_string(short handle, short max_length, short echo_mode, short *echo_xy, char *string);
short vsm_type(short handle, short type);
void vsm_valuator(short handle, short val_in, short *val_out, short *term, short *status);
void vsp_message(short handle);
void vsp_save(short handle);
void vsp_state(short handle, short port, short film_num, short lightness, short interlace, short planes, short *indexes);
void vst_alignment(short handle, short hor_in, short vert_in, short *hor_out, short *vert_out);
short vst_color(short handle, short color_index);
short vst_effects(short handle, short effect);
short vst_font(short handle, short font);
void vst_height(short handle, short height, short *char_width, short *char_height, short *cell_width, short *cell_height);
short vst_load_fonts(short handle, short select);
short vst_point(short handle, short point, short *char_width, short *char_height, short *cell_width, short *cell_height);
short vst_rotation(short handle, short angle);
short vst_unload_fonts(short handle, short select);
short vswr_mode(short handle, short mode);

#endif /* __GEMBIND__ */
