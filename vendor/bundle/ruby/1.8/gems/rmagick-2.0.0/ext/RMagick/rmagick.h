/* $Id: rmagick.h,v 1.211 2007/12/26 21:41:48 rmagick Exp $ */
/*=============================================================================
|               Copyright (C) 2006 by Timothy P. Hunter
| Name:     rmagick.h
| Purpose:  RMagick declarations and definitions
| Author:   Tim Hunter
\============================================================================*/

#ifndef _RMAGICK_H_
#define _RMAGICK_H_

#include <assert.h>
#include <stdio.h>
#include <ctype.h>
#include <stdint.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#if defined(HAVE_SYS_TYPES_H)
#include <sys/types.h>
#endif
#include "ruby.h"
#if defined(HAVE_RUBY_INTERN_H)
#include "ruby/intern.h"
#else
#include "intern.h"
#endif
#include "rubyio.h"


// Undef Ruby's versions of these symbols
#undef PACKAGE_VERSION
#undef PACKAGE_NAME
#undef PACKAGE_STRING
#undef PACKAGE_BUGREPORT
#undef PACKAGE_TARNAME

#include "magick/MagickCore.h"

// Undef ImageMagick's versions of these symbols
#undef PACKAGE_STRING


#include "extconf.h"


// For quoting preprocessor symbols
#define Q2(q) #q
#define Q(q) Q2(q)


// Trace new image creation in bang methods
#define UPDATE_DATA_PTR(_obj_, _new_) \
    do { (void) rm_trace_creation(_new_);\
    DATA_PTR(_obj_) = (void *)(_new_);\
    } while(0)


// Handle Quantum <-> Ruby Numeric object conversion
#if (QuantumDepth == 8 || QuantumDepth == 16)
#define QUANTUM2NUM(q) INT2FIX((q))
#define NUM2QUANTUM(n) (Quantum)NUM2UINT((n))
#elif (QuantumDepth == 32)
#define QUANTUM2NUM(q) UINT2NUM((q))
#define NUM2QUANTUM(n) (Quantum)NUM2UINT((n))
#elif (QuantumDepth == 64)
#define QUANTUM2NUM(q) ULL2NUM((q))
#define NUM2QUANTUM(n) (Quantum)NUM2ULL((n))
#else
#error Specified QuantumDepth is not supported.
#endif
// Convert user-supplied objects to Quantum
#define APP2QUANTUM(n) rm_app2quantum((n))

#undef DegreesToRadians     // defined in ImageMagick.h in 6.0.2
#define DegreesToRadians(x) ((x)*3.14159265358979323846/180.0)

#define PIXEL_INTENSITY(q) \
        ((Quantum)(0.299*(q)->red + 0.587*(q)->green + 0.114*(q)->blue + 0.5))

#define LMAX(a,b) ((((long)(a))>((long)(b)))?((long)(a)):((long)(b)))
#define FMAX(a,b) ((((double)(a))>((double)(b)))?((double)(a)):((double)(b)))
#define FMIN(a,b) ((((double)(a))<=((double)(b)))?((double)(a)):((double)(b)))
#define RMAGICK_PI 3.14159265358979
#define ROUND_TO_QUANTUM(value) ((Quantum) ((value) > (Quantum)QuantumRange ? QuantumRange : (value) + 0.5))


// Ruby 1.9.0 changed the name to rb_frame_this_func
#if defined(HAVE_RB_FRAME_THIS_FUNC)
#define THIS_FUNC() rb_frame_this_func()
#else
#define THIS_FUNC() rb_frame_last_func()
#endif

// GetReadFile doesn't exist in Ruby 1.9.0
#if !defined(GetReadFile)
#define GetReadFile(fptr) rb_io_stdio_file(fptr)
#define GetWriteFile(fptr) rb_io_stdio_file(fptr)
#endif

// rb_io_t replaces OpenFile in Ruby 1.9.0
#if defined(HAVE_RB_IO_T)
#undef OpenFile
#define OpenFile rb_io_t
#endif

// ImageLayerMethod replaced MagickLayerMethod starting with 6.3.6
#if defined(HAVE_TYPE_IMAGELAYERMETHOD)
#define LAYERMETHODTYPE ImageLayerMethod
#define CLASS_LAYERMETHODTYPE Class_ImageLayerMethod
#define LAYERMETHODTYPE_NAME ImageLayerMethod_name
#define LAYERMETHODTYPE_NEW  ImageLayerMethod_new
#else
#define LAYERMETHODTYPE MagickLayerMethod
#define CLASS_LAYERMETHODTYPE Class_MagickLayerMethod
#define LAYERMETHODTYPE_NAME MagickLayerMethod_name
#define LAYERMETHODTYPE_NEW  MagickLayerMethod_new
#endif


typedef ImageInfo Info; // Make type name match class name
typedef PixelPacket Pixel;

// Montage
typedef struct
{
    CompositeOperator compose;
    MontageInfo *info;
} Montage;

// Draw
struct TmpFile_Name
{
    struct TmpFile_Name *next;
    char name[1];
};

typedef struct
{
    DrawInfo *info;             // the DrawInfo struct
    VALUE primitives;           // the primitive string
    struct TmpFile_Name *tmpfile_ary;
    PixelPacket shadow_color;   // PolaroidOptions#shadow_color
} Draw;             // make the type match the class name

// Enum
typedef struct
{
   ID id;
   int val;
} MagickEnum;

#undef False    // defined in deprecate.h in 6.0.2
#undef True     // defined in deprecate.h in 6.0.2
typedef enum
{
    False = 0,
    True = 1
} rm_boolean;

typedef enum {
    AnyWeight,
    NormalWeight,
    BoldWeight,
    BolderWeight,
    LighterWeight
} WeightType;

// Draw#text_anchor AnchorType argument
typedef enum {
    StartAnchor = 1,
    MiddleAnchor = 2,
    EndAnchor = 3
} AnchorType;


typedef struct
{
    unsigned char id;   // Dumped image id = 0xd1
    unsigned char mj;   // Major format number = 1
    unsigned char mi;   // Minor format number = 0
    unsigned char len;  // Length of image magick string
    char magick[MaxTextExtent]; // magick string
} DumpedImage;

#define DUMPED_IMAGE_ID      0xd1
#define DUMPED_IMAGE_MAJOR_VERS 1
#define DUMPED_IMAGE_MINOR_VERS 0

#define MAGICK_LOC "magick_location"     // instance variable name in ImageMagickError class

#define MAX_GEOM_STR 51                 // max length of a geometry string

/*
 * Both ImageMagick and GraphicsMagick define an enum type for quantum-level
 * expressions, but they're different types. The QuantumExpressionOperator
 * type is an adapter type that can be mapped to either one.
*/
typedef enum _QuantumExpressionOperator
{
    UndefinedQuantumOperator,
    AddQuantumOperator,
    AndQuantumOperator,
    DivideQuantumOperator,
    LShiftQuantumOperator,
    MaxQuantumOperator,
    MinQuantumOperator,
    MultiplyQuantumOperator,
    OrQuantumOperator,
    RShiftQuantumOperator,
    SubtractQuantumOperator,
    XorQuantumOperator
} QuantumExpressionOperator ;


// This implements the "omitted storage class model" for external variables.
// (Ref: Harbison & Steele.) The rmmain.c file defines MAIN, which causes
// the single defining declarations to be generated. No other source files
// define MAIN and therefore generate referencing declarations.
#undef EXTERN
#if defined(MAIN)
#define EXTERN
#else
#define EXTERN extern
#endif

/*
*   RMagick Module and Class VALUEs
*/
EXTERN VALUE Module_Magick;
EXTERN VALUE Class_ImageList;
EXTERN VALUE Class_Info;
EXTERN VALUE Class_Draw;
EXTERN VALUE Class_DrawOptions;
EXTERN VALUE Class_Image;
EXTERN VALUE Class_Montage;
EXTERN VALUE Class_ImageMagickError;
EXTERN VALUE Class_DestroyedImageError;
EXTERN VALUE Class_GradientFill;
EXTERN VALUE Class_TextureFill;
EXTERN VALUE Class_AffineMatrix;
EXTERN VALUE Class_Chromaticity;
EXTERN VALUE Class_Color;
EXTERN VALUE Class_Font;
EXTERN VALUE Class_Geometry;
EXTERN VALUE Class_GeometryValue;   // Defined in RMagick.rb
EXTERN VALUE Class_Pixel;
EXTERN VALUE Class_Point;
EXTERN VALUE Class_PolaroidOptions;
EXTERN VALUE Class_Primary;
EXTERN VALUE Class_Rectangle;
EXTERN VALUE Class_Segment;
EXTERN VALUE Class_TypeMetric;
EXTERN VALUE Class_MetricType;
EXTERN VALUE Class_QuantumExpressionOperator;

// Enum classes
EXTERN VALUE Class_Enum;
EXTERN VALUE Class_AlignType;
EXTERN VALUE Class_AlphaChannelType;
EXTERN VALUE Class_AnchorType;
EXTERN VALUE Class_ChannelType;
EXTERN VALUE Class_ClassType;
EXTERN VALUE Class_ColorspaceType;
EXTERN VALUE Class_ComplianceType;
EXTERN VALUE Class_CompositeOperator;
EXTERN VALUE Class_CompressionType;
EXTERN VALUE Class_DecorationType;
EXTERN VALUE Class_DisposeType;
#if defined(HAVE_DISTORTIMAGE)
EXTERN VALUE Class_DistortImageMethod;
#endif
EXTERN VALUE Class_EndianType;
EXTERN VALUE Class_FilterTypes;
EXTERN VALUE Class_GravityType;
EXTERN VALUE Class_ImageType;
EXTERN VALUE Class_InterlaceType;
EXTERN VALUE Class_InterpolatePixelMethod;
EXTERN VALUE CLASS_LAYERMETHODTYPE;
EXTERN VALUE Class_NoiseType;
EXTERN VALUE Class_OrientationType;
EXTERN VALUE Class_PaintMethod;
EXTERN VALUE Class_PreviewType;
EXTERN VALUE Class_RenderingIntent;
EXTERN VALUE Class_ResolutionType;
EXTERN VALUE Class_StorageType;
EXTERN VALUE Class_StretchType;
EXTERN VALUE Class_StyleType;
EXTERN VALUE Class_WeightType;
EXTERN VALUE Class_VirtualPixelMethod;

/*
*   Commonly-used IDs
*/
EXTERN ID rm_ID_trace_proc;        // "@trace_proc"
EXTERN ID rm_ID__dummy_img_;       // "_dummy_img_"
EXTERN ID rm_ID_call;              // "call"
EXTERN ID rm_ID_changed;           // "changed"
EXTERN ID rm_ID_cur_image;         // "cur_image"
EXTERN ID rm_ID_dup;               // "dup"
EXTERN ID rm_ID_enumerators;       // "enumerators"
EXTERN ID rm_ID_fill;              // "fill"
EXTERN ID rm_ID_flag;              // "flag"
EXTERN ID rm_ID_from_s;            // "from_s"
EXTERN ID rm_ID_Geometry;          // "Geometry"
EXTERN ID rm_ID_GeometryValue;     // "GeometryValue"
EXTERN ID rm_ID_height;            // "height"
EXTERN ID rm_ID_initialize_copy;   // "initialize_copy"
EXTERN ID rm_ID_length;            // "length"
EXTERN ID rm_ID_notify_observers;  // "notify_observers"
EXTERN ID rm_ID_new;               // "new"
EXTERN ID rm_ID_push;              // "push"
EXTERN ID rm_ID_spaceship;         // "<=>
EXTERN ID rm_ID__tmpnam_;          // "_tmpnam_"
EXTERN ID rm_ID_to_i;              // "to_i"
EXTERN ID rm_ID_to_s;              // "to_s"
EXTERN ID rm_ID_values;            // "values"
EXTERN ID rm_ID_width;             // "width"
EXTERN ID rm_ID_x;                 // "x"
EXTERN ID rm_ID_y;                 // "y"


#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

/*
   Handle warnings & errors
*/
#define CHECK_EXCEPTION() rm_check_exception(&exception, NULL, RetainOnError);


/*
    Call rb_define_method for an attribute accessor method
*/
#define DCL_ATTR_READER(class, attr) \
    rb_define_method(Class_##class, #attr, class##_##attr, 0);
#define DCL_ATTR_WRITER(class, attr) \
    rb_define_method(Class_##class, #attr "=", class##_##attr##_eq, 1);
#define DCL_ATTR_ACCESSOR(class, attr) \
    DCL_ATTR_READER(class, attr) \
    DCL_ATTR_WRITER(class, attr)
// Borrow another class' attribute writer definition
#define SHARE_ATTR_WRITER(to, from, attr) \
    rb_define_method(Class_##to, #attr "=", from##_##attr##_eq, 1);

/*
    Define simple attribute accessor methods (boolean, int, string, and double types)
*/
#define C_bool_to_R_bool(attr) (attr) ? Qtrue : Qfalse
#define R_bool_to_C_bool(attr) RTEST(attr)
#define C_int_to_R_int(attr) INT2FIX(attr)
#define R_int_to_C_int(attr) NUM2INT(attr)
#define C_long_to_R_long(attr) INT2NUM(attr)
#define R_long_to_C_long(attr) NUM2LONG(attr)
#define C_ulong_to_R_ulong(attr) UINT2NUM(attr)
#define R_ulong_to_C_ulong(attr) NUM2ULONG(attr)
#define C_str_to_R_str(attr) attr ? rb_str_new2(attr) : Qnil
#define C_dbl_to_R_dbl(attr) rb_float_new(attr)
#define R_dbl_to_C_dbl(attr) NUM2DBL(attr)

#define DEF_ATTR_READER(class, attr, type) \
    VALUE class##_##attr(VALUE self)\
    {\
        class *ptr;\
        if (rb_obj_is_kind_of(self, Class_Image) == Qtrue) {\
            (void) rm_check_destroyed(self); \
        }\
        Data_Get_Struct(self, class, ptr);\
        return C_##type##_to_R_##type(ptr->attr);\
    }

// Use when attribute name is different from the field name
#define DEF_ATTR_READERF(class, attr, field, type) \
    VALUE class##_##attr(VALUE self)\
    {\
        class *ptr;\
        (void) rm_check_destroyed(self); \
        Data_Get_Struct(self, class, ptr);\
        return C_##type##_to_R_##type(ptr->field);\
    }
#define DEF_ATTR_WRITER(class, attr, type) \
    VALUE class##_##attr##_eq(VALUE self, VALUE val)\
    {\
        class *ptr;\
        if (rb_obj_is_kind_of(self, Class_Image) == Qtrue) {\
            (void) rm_check_destroyed(self); \
        }\
        rb_check_frozen(self);\
        Data_Get_Struct(self, class, ptr);\
        ptr->attr = R_##type##_to_C_##type(val);\
        return self;\
    }
#define DEF_ATTR_ACCESSOR(class, attr, type)\
    DEF_ATTR_READER(class, attr, type)\
    DEF_ATTR_WRITER(class, attr, type)

/*
 *  Declare attribute accessors
 */
#define ATTR_READER(class, attr) \
    extern VALUE class##_##attr(VALUE);
#define ATTR_WRITER(class, attr) \
    extern VALUE class##_##attr##_eq(VALUE, VALUE);
#define ATTR_ACCESSOR(class, attr) \
    ATTR_READER(class, attr)\
    ATTR_WRITER(class, attr)

/*
 *  Define functions to get/set attributes in Image::Info that
 *  use the Get/SetImageOption API.
*/
#define OPTION_ATTR_READER(opt, key) \
    VALUE Info_##opt(VALUE self)\
    {\
        return get_option(self, #key);\
    }
#define OPTION_ATTR_WRITER(opt, key) \
    VALUE Info_##opt##_eq(VALUE self, VALUE string)\
    {\
        return set_option(self, #key, string);\
    }
#define OPTION_ATTR_ACCESSOR(opt, key)\
    OPTION_ATTR_READER(opt, key)\
    OPTION_ATTR_WRITER(opt, key)


/*
 *  Declare Pixel channel attribute writers
*/
#define DEF_PIXEL_CHANNEL_WRITER(_channel_) \
extern VALUE \
Pixel_##_channel_##_eq(VALUE self, VALUE v) \
{ \
    Pixel *pixel; \
 \
    rb_check_frozen(self); \
    Data_Get_Struct(self, Pixel, pixel); \
    pixel->_channel_ = APP2QUANTUM(v); \
    (void) rb_funcall(self, rm_ID_changed, 0); \
    (void) rb_funcall(self, rm_ID_notify_observers, 1, self); \
    return QUANTUM2NUM((pixel->_channel_)); \
}


/*
 *  Declare Pixel CMYK channel attribute accessors
*/
#define DEF_PIXEL_CMYK_CHANNEL_ACCESSOR(_cmyk_channel_, _rgb_channel_) \
extern VALUE \
Pixel_##_cmyk_channel_##_eq(VALUE self, VALUE v) \
{ \
    Pixel *pixel; \
 \
    rb_check_frozen(self); \
    Data_Get_Struct(self, Pixel, pixel); \
    pixel->_rgb_channel_ = APP2QUANTUM(v); \
    (void) rb_funcall(self, rm_ID_changed, 0); \
    (void) rb_funcall(self, rm_ID_notify_observers, 1, self); \
    return QUANTUM2NUM(pixel->_rgb_channel_); \
} \
 \
extern VALUE \
Pixel_##_cmyk_channel_(VALUE self) \
{ \
    Pixel *pixel; \
 \
    Data_Get_Struct(self, Pixel, pixel); \
    return INT2NUM(pixel->_rgb_channel_); \
}


/*
 *  Enum constants - define a subclass of Enum for the specified enumeration.
 *  Define an instance of the subclass for each member in the enumeration.
 *  Initialize each instance with its name and value.
 */
#define DEF_ENUM(tag) {\
   VALUE _cls, _enum;\
   _cls =  Class_##tag = rm_define_enum_type(#tag);

#define ENUMERATOR(val)\
   _enum = rm_enum_new(_cls, ID2SYM(rb_intern(#val)), INT2FIX(val));\
   rb_define_const(Module_Magick, #val, _enum);
#define END_ENUM }

//  Define a Magick module constant
#if QuantumDepth == 64
#define DEF_CONST(constant) rb_define_const(Module_Magick, #constant, ULL2NUM(constant))
#else   // QuantumDepth == 8, 16, 32
#define DEF_CONST(constant) rb_define_const(Module_Magick, #constant, UINT2NUM(constant))
#endif


// Convert a Ruby enum constant back to a C enum member.
#define VALUE_TO_ENUM(value, e, type) \
   do {\
   MagickEnum *magick_enum;\
   if (CLASS_OF(value) != Class_##type)\
       rb_raise(rb_eTypeError, "wrong enumeration type - expected %s, got %s"\
                   , rb_class2name(Class_##type),rb_class2name(CLASS_OF(value)));\
   Data_Get_Struct(value, MagickEnum, magick_enum);\
   e = (type)(magick_enum->val);\
   } while(0)

#define ENUM_TO_NAME(_enum) case _enum: return #_enum;


// Method, external function declarations. These declarations are
// grouped by the source file in which the methods are defined.

// We don't need any "extern/no extern" stuff here. An external function
// declaration can refer to a function defined in another source file or
// the same source file.

// rmdraw.c
ATTR_WRITER(Draw, affine)
ATTR_WRITER(Draw, align)
ATTR_WRITER(Draw, border_color)
ATTR_WRITER(Draw, decorate)
ATTR_WRITER(Draw, density)
ATTR_WRITER(Draw, encoding)
ATTR_WRITER(Draw, fill)
ATTR_WRITER(Draw, fill_pattern)
ATTR_WRITER(Draw, font)
ATTR_WRITER(Draw, font_family)
ATTR_WRITER(Draw, font_stretch)
ATTR_WRITER(Draw, font_style)
ATTR_WRITER(Draw, font_weight)
ATTR_WRITER(Draw, gravity)
ATTR_WRITER(Draw, pointsize)
ATTR_WRITER(Draw, rotation)
ATTR_WRITER(Draw, stroke)
ATTR_WRITER(Draw, stroke_pattern)
ATTR_WRITER(Draw, stroke_width)
ATTR_WRITER(Draw, text_antialias)
ATTR_WRITER(Draw, tile)
ATTR_WRITER(Draw, undercolor)
extern VALUE Draw_annotate(VALUE, VALUE, VALUE, VALUE, VALUE, VALUE, VALUE);
extern VALUE Draw_clone(VALUE);
extern VALUE Draw_composite(int, VALUE *, VALUE);
extern VALUE Draw_draw(VALUE, VALUE);
extern VALUE Draw_dup(VALUE);
extern VALUE Draw_get_multiline_type_metrics(int, VALUE *, VALUE);
extern VALUE Draw_get_type_metrics(int, VALUE *, VALUE);
extern VALUE Draw_init_copy(VALUE, VALUE);
extern VALUE Draw_initialize(VALUE);
extern VALUE Draw_inspect(VALUE);
extern VALUE Draw_alloc(VALUE);
extern VALUE DrawOptions_alloc(VALUE);
extern VALUE Draw_primitive(VALUE, VALUE);
extern VALUE DrawOptions_initialize(VALUE);


ATTR_WRITER(Montage, background_color)
ATTR_WRITER(Montage, border_color)
ATTR_WRITER(Montage, border_width)
ATTR_WRITER(Montage, compose)
ATTR_WRITER(Montage, filename)
ATTR_WRITER(Montage, fill)
ATTR_WRITER(Montage, font)
ATTR_WRITER(Montage, frame)
ATTR_WRITER(Montage, geometry)
ATTR_WRITER(Montage, gravity)
ATTR_WRITER(Montage, matte_color)
ATTR_WRITER(Montage, pointsize)
ATTR_WRITER(Montage, shadow)
ATTR_WRITER(Montage, stroke)
ATTR_WRITER(Montage, texture)
ATTR_WRITER(Montage, tile)
ATTR_WRITER(Montage, title)
extern VALUE Montage_initialize(VALUE);
extern VALUE Montage_alloc(VALUE);
extern VALUE rm_montage_new(void);


extern VALUE PolaroidOptions_alloc(VALUE);
extern VALUE PolaroidOptions_initialize(VALUE);
extern VALUE rm_polaroid_new(void);
ATTR_WRITER(PolaroidOptions, shadow_color);
ATTR_WRITER(PolaroidOptions, border_color);


// rmmain.c
extern VALUE rm_montage_new(void);


 // rmilist.c
extern VALUE ImageList_animate(int, VALUE *, VALUE);
extern VALUE ImageList_append(VALUE, VALUE);
extern VALUE ImageList_average(VALUE);
extern VALUE ImageList_coalesce(VALUE);
extern VALUE ImageList_composite_layers(int, VALUE *, VALUE);
extern VALUE ImageList_deconstruct(VALUE);
extern VALUE ImageList_display(VALUE);
extern VALUE ImageList_flatten_images(VALUE);
extern VALUE ImageList_fx(int, VALUE *, VALUE);
extern VALUE ImageList_map(int, VALUE *, VALUE);
extern VALUE ImageList_montage(VALUE);
extern VALUE ImageList_morph(VALUE, VALUE);
extern VALUE ImageList_mosaic(VALUE);
extern VALUE ImageList_optimize_layers(VALUE, VALUE);
extern VALUE ImageList_quantize(int, VALUE*, VALUE);
extern VALUE ImageList_to_blob(VALUE);
extern VALUE ImageList_write(VALUE, VALUE);

extern VALUE rm_imagelist_from_images(Image *);


// rminfo.c
ATTR_ACCESSOR(Info, antialias)
ATTR_ACCESSOR(Info, attenuate)
ATTR_ACCESSOR(Info, authenticate)
ATTR_ACCESSOR(Info, background_color)
ATTR_ACCESSOR(Info, border_color)
ATTR_ACCESSOR(Info, colorspace)
ATTR_ACCESSOR(Info, comment)
ATTR_ACCESSOR(Info, compression)
ATTR_ACCESSOR(Info, delay)
ATTR_ACCESSOR(Info, density)
ATTR_ACCESSOR(Info, depth)
ATTR_ACCESSOR(Info, dispose)
ATTR_ACCESSOR(Info, dither)
ATTR_ACCESSOR(Info, extract)
ATTR_ACCESSOR(Info, filename)
ATTR_ACCESSOR(Info, fill)
ATTR_ACCESSOR(Info, font)
ATTR_ACCESSOR(Info, format)
ATTR_ACCESSOR(Info, fuzz)
ATTR_ACCESSOR(Info, gravity)
ATTR_ACCESSOR(Info, group)
ATTR_ACCESSOR(Info, image_type)
ATTR_ACCESSOR(Info, interlace)
ATTR_ACCESSOR(Info, label)
ATTR_ACCESSOR(Info, matte_color)
ATTR_WRITER(Info, monitor)
ATTR_ACCESSOR(Info, monochrome)
ATTR_ACCESSOR(Info, number_scenes)
ATTR_ACCESSOR(Info, orientation)
ATTR_ACCESSOR(Info, origin)
ATTR_ACCESSOR(Info, page)
ATTR_ACCESSOR(Info, pen)
// ATTR_ACCESSOR(Info, ping) obsolete
ATTR_ACCESSOR(Info, pointsize)
ATTR_ACCESSOR(Info, quality)
ATTR_ACCESSOR(Info, sampling_factor)
ATTR_ACCESSOR(Info, scene)
ATTR_ACCESSOR(Info, server_name)
ATTR_ACCESSOR(Info, size)
ATTR_ACCESSOR(Info, stroke)
ATTR_ACCESSOR(Info, stroke_width)
ATTR_WRITER(Info, texture)
ATTR_ACCESSOR(Info, tile_offset)
ATTR_ACCESSOR(Info, undercolor)
ATTR_ACCESSOR(Info, units)
ATTR_ACCESSOR(Info, view)
//ATTR_ACCESSOR(Info, verbose)

extern VALUE Info_alloc(VALUE);

extern VALUE Info_define(int, VALUE *, VALUE);
extern VALUE Info_aset(int, VALUE *, VALUE);
extern VALUE Info_aref(int, VALUE *, VALUE);
extern VALUE Info_channel(int, VALUE *, VALUE);
extern VALUE Info_undefine(VALUE, VALUE, VALUE);
extern VALUE Info_initialize(VALUE);
extern VALUE rm_info_new(void);


// rmimage.c
ATTR_WRITER(Image, alpha)
ATTR_ACCESSOR(Image, background_color)
ATTR_READER(Image, base_columns)
ATTR_READER(Image, base_filename)
ATTR_READER(Image, base_rows)
ATTR_ACCESSOR(Image, bias)
ATTR_ACCESSOR(Image, black_point_compensation)
ATTR_ACCESSOR(Image, blur)
ATTR_ACCESSOR(Image, border_color)
ATTR_READER(Image, bounding_box)
ATTR_ACCESSOR(Image, chromaticity)
ATTR_ACCESSOR(Image, class_type)
ATTR_ACCESSOR(Image, color_profile)
ATTR_READER(Image, colors)
ATTR_ACCESSOR(Image, colorspace)
ATTR_READER(Image, columns)
ATTR_ACCESSOR(Image, compose)
ATTR_ACCESSOR(Image, compression)
ATTR_ACCESSOR(Image, delay)
ATTR_ACCESSOR(Image, density)
ATTR_READER(Image, depth)
ATTR_READER(Image, directory)
ATTR_ACCESSOR(Image, dispose)
ATTR_ACCESSOR(Image, endian)
ATTR_ACCESSOR(Image, extract_info)
ATTR_READER(Image, filename)
ATTR_READER(Image, filesize)
ATTR_ACCESSOR(Image, filter)
ATTR_ACCESSOR(Image, format)
ATTR_ACCESSOR(Image, fuzz)
ATTR_ACCESSOR(Image, gamma)
ATTR_ACCESSOR(Image, geometry)
ATTR_ACCESSOR(Image, gravity)
ATTR_READER(Image, image_type)
ATTR_ACCESSOR(Image, interlace)
ATTR_ACCESSOR(Image, iptc_profile)
ATTR_ACCESSOR(Image, iterations)
ATTR_ACCESSOR(Image, mask)
ATTR_ACCESSOR(Image, matte)
ATTR_ACCESSOR(Image, matte_color)
ATTR_READER(Image, mean_error_per_pixel)
ATTR_READER(Image, mime_type)
ATTR_WRITER(Image, monitor)
ATTR_READER(Image, montage)
ATTR_READER(Image, normalized_mean_error)
ATTR_READER(Image, normalized_maximum_error)
ATTR_READER(Image, number_colors)
ATTR_ACCESSOR(Image, offset)
ATTR_WRITER(Image, opacity)
ATTR_ACCESSOR(Image, orientation)
ATTR_ACCESSOR(Image, page)
ATTR_ACCESSOR(Image, pixel_interpolation_method)
ATTR_READER(Image, quality)
ATTR_READER(Image, quantum_depth)
ATTR_ACCESSOR(Image, rendering_intent)
ATTR_READER(Image, rows)
ATTR_READER(Image, scene)
ATTR_ACCESSOR(Image, start_loop)
ATTR_ACCESSOR(Image, ticks_per_second)
ATTR_READER(Image, total_colors)
ATTR_ACCESSOR(Image, transparent_color)
ATTR_ACCESSOR(Image, units)
ATTR_ACCESSOR(Image, virtual_pixel_method)
ATTR_ACCESSOR(Image, x_resolution)
ATTR_ACCESSOR(Image, y_resolution)

extern ChannelType extract_channels(int *, VALUE *);
extern void raise_ChannelType_error(VALUE);

extern VALUE Image_alloc(VALUE);
extern VALUE Image_initialize(int, VALUE *, VALUE);
extern VALUE Image_adaptive_blur(int, VALUE *, VALUE);
extern VALUE Image_adaptive_blur_channel(int, VALUE *, VALUE);
extern VALUE Image_adaptive_resize(int, VALUE *, VALUE);
extern VALUE Image_adaptive_sharpen(int, VALUE *, VALUE);
extern VALUE Image_adaptive_sharpen_channel(int, VALUE *, VALUE);
extern VALUE Image_adaptive_threshold(int, VALUE *, VALUE);
extern VALUE Image_add_noise(VALUE, VALUE);
extern VALUE Image_add_noise_channel(int, VALUE *, VALUE);
extern VALUE Image_add_profile(VALUE, VALUE);
extern VALUE Image_affine_transform(VALUE, VALUE);
extern VALUE Image_aref(VALUE, VALUE);
extern VALUE Image_aset(VALUE, VALUE, VALUE);
extern VALUE Image_auto_orient(VALUE);
extern VALUE Image_auto_orient_bang(VALUE);
extern VALUE Image_properties(VALUE);
extern VALUE Image_bilevel_channel(int, VALUE *, VALUE);
extern VALUE Image_black_threshold(int, VALUE *, VALUE);
extern VALUE Image_blend(int, VALUE *, VALUE);
extern VALUE Image_blur_image(int, VALUE *, VALUE);
extern VALUE Image_blur_channel(int, VALUE *, VALUE);
extern VALUE Image_border(VALUE, VALUE, VALUE, VALUE);
extern VALUE Image_border_bang(VALUE, VALUE, VALUE, VALUE);
extern VALUE Image_capture(int, VALUE *, VALUE);
extern VALUE Image_change_geometry(VALUE, VALUE);
extern VALUE Image_changed_q(VALUE);
extern VALUE Image_channel(VALUE, VALUE);
extern VALUE Image_check_destroyed(VALUE);
extern VALUE Image_compare_channel(int, VALUE *, VALUE);
extern VALUE Image_channel_depth(int, VALUE *, VALUE);
extern VALUE Image_channel_extrema(int, VALUE *, VALUE);
extern VALUE Image_channel_mean(int, VALUE *, VALUE);
extern VALUE Image_charcoal(int, VALUE *, VALUE);
extern VALUE Image_chop(VALUE, VALUE, VALUE, VALUE, VALUE);
extern VALUE Image_clone(VALUE);
extern VALUE Image_clut_channel(int, VALUE *, VALUE);
extern VALUE Image_color_flood_fill(VALUE, VALUE, VALUE, VALUE, VALUE, VALUE);
extern VALUE Image_color_histogram(VALUE);
extern VALUE Image_colorize(int, VALUE *, VALUE);
extern VALUE Image_colormap(int, VALUE *, VALUE);
extern VALUE Image_combine(int, VALUE *, VALUE);
extern VALUE Image_composite(int, VALUE *, VALUE);
extern VALUE Image_composite_bang(int, VALUE *, VALUE);
extern VALUE Image_composite_channel(int, VALUE *, VALUE);
extern VALUE Image_composite_channel_bang(int, VALUE *, VALUE);
extern VALUE Image_composite_affine(VALUE, VALUE, VALUE);
extern VALUE Image_compress_colormap_bang(VALUE);
extern VALUE Image_constitute(VALUE, VALUE, VALUE, VALUE, VALUE);
extern VALUE Image_contrast(int, VALUE *, VALUE);
extern VALUE Image_contrast_stretch_channel(int, VALUE *, VALUE);
extern VALUE Image_convolve(VALUE, VALUE, VALUE);
extern VALUE Image_convolve_channel(int, VALUE *, VALUE);
extern VALUE Image_copy(VALUE);
extern VALUE Image_crop(int, VALUE *, VALUE);
extern VALUE Image_crop_bang(int, VALUE *, VALUE);
extern VALUE Image_cycle_colormap(VALUE, VALUE);
extern VALUE Image_delete_profile(VALUE, VALUE);
extern VALUE Image_despeckle(VALUE);
extern VALUE Image_destroy_bang(VALUE);
extern VALUE Image_destroyed_q(VALUE);
extern VALUE Image_difference(VALUE, VALUE);
extern VALUE Image_dispatch(int, VALUE *, VALUE);
extern VALUE Image_displace(int, VALUE *, VALUE);
extern VALUE Image_display(VALUE);
extern VALUE Image_dissolve(int, VALUE *, VALUE);
extern VALUE Image_distort(int, VALUE *, VALUE);
extern VALUE Image_distortion_channel(int, VALUE *, VALUE);
extern VALUE Image__dump(VALUE, VALUE);
extern VALUE Image_dup(VALUE);
extern VALUE Image_each_profile(VALUE);
extern VALUE Image_edge(int, VALUE *, VALUE);
extern VALUE Image_emboss(int, VALUE *, VALUE);
extern VALUE Image_enhance(VALUE);
extern VALUE Image_equalize(VALUE);
extern VALUE Image_equalize_channel(int, VALUE *, VALUE);
extern VALUE Image_erase_bang(VALUE);
extern VALUE Image_excerpt(VALUE, VALUE, VALUE, VALUE, VALUE);
extern VALUE Image_excerpt_bang(VALUE, VALUE, VALUE, VALUE, VALUE);
extern VALUE Image_export_pixels(int, VALUE *, VALUE);
extern VALUE Image_export_pixels_to_str(int, VALUE *, VALUE);
extern VALUE Image_extent(int, VALUE *, VALUE);
extern VALUE Image_find_similar_region(int, VALUE *, VALUE);
extern VALUE Image_flip(VALUE);
extern VALUE Image_flip_bang(VALUE);
extern VALUE Image_flop(VALUE);
extern VALUE Image_flop_bang(VALUE);
extern VALUE Image_frame(int, VALUE *, VALUE);
extern VALUE Image_from_blob(VALUE, VALUE);
extern VALUE Image_gamma_channel(int, VALUE *, VALUE);
extern VALUE Image_gamma_correct(int, VALUE *, VALUE);
extern VALUE Image_gaussian_blur(int, VALUE *, VALUE);
extern VALUE Image_gaussian_blur_channel(int, VALUE *, VALUE);
extern VALUE Image_get_pixels(VALUE, VALUE, VALUE, VALUE, VALUE);
extern VALUE Image_gray_q(VALUE);
extern VALUE Image_histogram_q(VALUE);
extern VALUE Image_implode(int, VALUE *, VALUE);
extern VALUE Image_import_pixels(int, VALUE *, VALUE);
extern VALUE Image_init_copy(VALUE, VALUE);
extern VALUE Image_inspect(VALUE);
extern VALUE Image_level2(int, VALUE *, VALUE);
extern VALUE Image_level_channel(int, VALUE *, VALUE);
extern VALUE Image_linear_stretch(int, VALUE *, VALUE);
extern VALUE Image__load(VALUE, VALUE);
extern VALUE Image_magnify(VALUE);
extern VALUE Image_magnify_bang(VALUE);
extern VALUE Image_map(int, VALUE *, VALUE);
extern VALUE Image_matte_flood_fill(VALUE, VALUE, VALUE, VALUE, VALUE, VALUE);
extern VALUE Image_median_filter(int, VALUE *, VALUE);
extern VALUE Image_minify(VALUE);
extern VALUE Image_minify_bang(VALUE);
extern VALUE Image_modulate(int, VALUE *, VALUE);
extern VALUE Image_monochrome_q(VALUE);
extern VALUE Image_motion_blur(int, VALUE *, VALUE);
extern VALUE Image_negate(int, VALUE *, VALUE);
extern VALUE Image_negate_channel(int, VALUE *, VALUE);
extern VALUE Image_normalize(VALUE);
extern VALUE Image_normalize_channel(int, VALUE *, VALUE);
extern VALUE Image_oil_paint(int, VALUE *, VALUE);
extern VALUE Image_opaque(VALUE, VALUE, VALUE);
extern VALUE Image_opaque_q(VALUE);
extern VALUE Image_ordered_dither(int, VALUE *, VALUE);
extern VALUE Image_palette_q(VALUE);
extern VALUE Image_ping(VALUE, VALUE);
extern VALUE Image_pixel_color(int, VALUE *, VALUE);
extern VALUE Image_polaroid(int, VALUE *, VALUE);
extern VALUE Image_posterize(int, VALUE *, VALUE);
extern VALUE Image_preview(VALUE, VALUE);
extern VALUE Image_profile_bang(VALUE, VALUE, VALUE);
extern VALUE Image_quantize(int, VALUE *, VALUE);
extern VALUE Image_quantization_error(VALUE);
extern VALUE Image_quantum_operator(int, VALUE *, VALUE);
extern VALUE Image_radial_blur(VALUE, VALUE);
extern VALUE Image_radial_blur_channel(int, VALUE *, VALUE);
extern VALUE Image_raise(int, VALUE *, VALUE);
extern VALUE Image_random_threshold_channel(int, VALUE *, VALUE);
extern VALUE Image_read(VALUE, VALUE);
extern VALUE Image_read_inline(VALUE, VALUE);
extern VALUE Image_recolor(VALUE, VALUE);
extern VALUE Image_reduce_noise(VALUE, VALUE);
extern VALUE Image_resize(int, VALUE *, VALUE);
extern VALUE Image_resize_bang(int, VALUE *, VALUE);
extern VALUE Image_roll(VALUE, VALUE, VALUE);
extern VALUE Image_rotate(int, VALUE *, VALUE);
extern VALUE Image_rotate_bang(int, VALUE *, VALUE);
extern VALUE Image_sample(int, VALUE *, VALUE);
extern VALUE Image_sample_bang(int, VALUE *, VALUE);
extern VALUE Image_scale(int, VALUE *, VALUE);
extern VALUE Image_scale_bang(int, VALUE *, VALUE);
extern VALUE Image_segment(int, VALUE *, VALUE);
extern VALUE Image_separate(int, VALUE *, VALUE);
extern VALUE Image_sepiatone(int, VALUE *, VALUE);
extern VALUE Image_set_channel_depth(VALUE, VALUE, VALUE);
extern VALUE Image_shade(int, VALUE *, VALUE);
extern VALUE Image_shadow(int, VALUE *, VALUE);
extern VALUE Image_sharpen(int, VALUE *, VALUE);
extern VALUE Image_sharpen_channel(int, VALUE *, VALUE);
extern VALUE Image_shave(VALUE, VALUE, VALUE);
extern VALUE Image_shave_bang(VALUE, VALUE, VALUE);
extern VALUE Image_shear(VALUE, VALUE, VALUE);
extern VALUE Image_sigmoidal_contrast_channel(int, VALUE *, VALUE);
extern VALUE Image_signature(VALUE);
extern VALUE Image_sketch(int, VALUE *, VALUE);
extern VALUE Image_solarize(int, VALUE *, VALUE);
extern VALUE Image_spaceship(VALUE, VALUE);
extern VALUE Image_splice(int, VALUE *, VALUE);
extern VALUE Image_spread(int, VALUE *, VALUE);
extern VALUE Image_stegano(VALUE, VALUE, VALUE);
extern VALUE Image_stereo(VALUE, VALUE);
extern VALUE Image_store_pixels(VALUE, VALUE, VALUE, VALUE, VALUE, VALUE);
extern VALUE Image_strip_bang(VALUE);
extern VALUE Image_swirl(VALUE, VALUE);
extern VALUE Image_sync_profiles(VALUE);
extern VALUE Image_texture_flood_fill(VALUE, VALUE, VALUE, VALUE, VALUE, VALUE);
extern VALUE Image_threshold(VALUE, VALUE);
extern VALUE Image_thumbnail(int, VALUE *, VALUE);
extern VALUE Image_thumbnail_bang(int, VALUE *, VALUE);
extern VALUE Image_tint(int, VALUE *, VALUE);
extern VALUE Image_to_blob(VALUE);
extern VALUE Image_to_color(VALUE, VALUE);
extern VALUE Image_transparent(int, VALUE *, VALUE);
extern VALUE Image_transpose(VALUE);
extern VALUE Image_transpose_bang(VALUE);
extern VALUE Image_transverse(VALUE);
extern VALUE Image_transverse_bang(VALUE);
extern VALUE Image_trim(int, VALUE *, VALUE);
extern VALUE Image_trim_bang(int, VALUE *, VALUE);
extern VALUE Image_unique_colors(VALUE);
extern VALUE Image_unsharp_mask(int, VALUE *, VALUE);
extern VALUE Image_unsharp_mask_channel(int, VALUE *, VALUE);
extern VALUE Image_vignette(int, VALUE *, VALUE);
extern VALUE Image_watermark(int, VALUE *, VALUE);
extern VALUE Image_wave(int, VALUE *, VALUE);
extern VALUE Image_wet_floor(int, VALUE *, VALUE);
extern VALUE Image_white_threshold(int, VALUE *, VALUE);
extern VALUE Image_write(VALUE, VALUE);

extern VALUE rm_image_new(Image *);
extern void  rm_image_destroy(void *);
extern void  rm_trace_creation(Image *);


// rmfill.c
extern VALUE  GradientFill_alloc(VALUE);
extern VALUE  GradientFill_initialize(VALUE, VALUE, VALUE, VALUE, VALUE, VALUE, VALUE);
extern VALUE  GradientFill_fill(VALUE, VALUE);

extern VALUE  TextureFill_alloc(VALUE);
extern VALUE  TextureFill_initialize(VALUE, VALUE);
extern VALUE  TextureFill_fill(VALUE, VALUE);


// rmutil.c
extern VALUE  ChromaticityInfo_to_s(VALUE);
extern VALUE  ChromaticityInfo_new(ChromaticityInfo *);
extern void   Color_to_PixelPacket(PixelPacket *, VALUE);
extern VALUE  Color_to_s(VALUE);
extern VALUE  Color_from_ColorInfo(const ColorInfo *);
extern VALUE  ClassType_new(ClassType);
extern VALUE  ColorspaceType_new(ColorspaceType);
extern VALUE  CompositeOperator_new(CompositeOperator);
extern VALUE  CompressionType_new(CompressionType);
extern VALUE  DisposeType_new(DisposeType);
extern VALUE  EndianType_new(EndianType);
extern VALUE  FilterTypes_new(FilterTypes);
extern VALUE  GravityType_new(GravityType);
extern VALUE  Font_to_s(VALUE);
extern VALUE  ImageList_cur_image(VALUE);
extern VALUE  ImageMagickError_initialize(int, VALUE *, VALUE);
extern VALUE  ImageType_new(ImageType);
extern VALUE  InterlaceType_new(InterlaceType);

extern VALUE   Pixel_alloc(VALUE);

ATTR_ACCESSOR(Pixel, red)
ATTR_ACCESSOR(Pixel, green)
ATTR_ACCESSOR(Pixel, blue)
ATTR_ACCESSOR(Pixel, opacity)
ATTR_ACCESSOR(Pixel, cyan)
ATTR_ACCESSOR(Pixel, magenta)
ATTR_ACCESSOR(Pixel, yellow)
ATTR_ACCESSOR(Pixel, black)
extern VALUE  Pixel_case_eq(VALUE, VALUE);
extern VALUE  Pixel_clone(VALUE);
extern VALUE  Pixel_dup(VALUE);
extern VALUE  Pixel_eql_q(VALUE, VALUE);
extern VALUE  Pixel_fcmp(int, VALUE *, VALUE);
extern VALUE  Pixel_from_color(VALUE, VALUE);
extern VALUE  Pixel_from_HSL(VALUE, VALUE);
extern VALUE  Pixel_hash(VALUE);
extern VALUE  Pixel_initialize(int, VALUE *, VALUE);
extern VALUE  Pixel_init_copy(VALUE, VALUE);
extern VALUE  Pixel_intensity(VALUE);
extern VALUE  Pixel_spaceship(VALUE, VALUE);
extern VALUE  Pixel_to_color(int, VALUE *, VALUE);
extern VALUE  Pixel_to_HSL(VALUE);
extern VALUE  Pixel_to_s(VALUE);
extern VALUE  PixelPacket_to_Color_Name(Image *, PixelPacket *);
extern VALUE  PixelPacket_to_Color_Name_Info(Info *, PixelPacket *);
extern VALUE  Pixel_from_PixelPacket(PixelPacket *);

extern void   Point_to_PointInfo(PointInfo *, VALUE);
extern VALUE  PointInfo_to_Point(PointInfo *);
extern VALUE  PrimaryInfo_to_s(VALUE);
extern VALUE  PrimaryInfo_from_PrimaryInfo(PrimaryInfo *);
extern VALUE  RectangleInfo_to_s(VALUE);
extern VALUE  Rectangle_from_RectangleInfo(RectangleInfo *);
extern VALUE  RenderingIntent_new(RenderingIntent);
extern VALUE  ResolutionType_new(ResolutionType);
extern VALUE  SegmentInfo_to_s(VALUE);
extern VALUE  Segment_from_SegmentInfo(SegmentInfo *);
extern void   AffineMatrix_to_AffineMatrix(AffineMatrix *, VALUE);
extern void   ChromaticityInfo_to_ChromaticityInfo(ChromaticityInfo *, VALUE);
extern void   Color_to_ColorInfo(ColorInfo *, VALUE);
extern VALUE  InterpolatePixelMethod_new(InterpolatePixelMethod);
extern VALUE  OrientationType_new(OrientationType);
extern void   PrimaryInfo_to_PrimaryInfo(PrimaryInfo *, VALUE);
extern void   Rectangle_to_RectangleInfo(RectangleInfo *, VALUE);
extern void   Segment_to_SegmentInfo(SegmentInfo *, VALUE);
extern void   Font_to_TypeInfo(TypeInfo *, VALUE);
extern void   TypeMetric_to_TypeMetric(TypeMetric *, VALUE);
extern VALUE  Font_from_TypeInfo(TypeInfo *);
extern VALUE  TypeMetric_to_s(VALUE);
extern VALUE  TypeMetric_from_TypeMetric(TypeMetric *);
extern const char *StorageType_name(StorageType);
extern VALUE  VirtualPixelMethod_new(VirtualPixelMethod);

extern VALUE  Enum_alloc(VALUE);
extern VALUE  Enum_initialize(VALUE, VALUE, VALUE);
extern VALUE  Enum_to_s(VALUE);
extern VALUE  Enum_to_i(VALUE);
extern VALUE  Enum_spaceship(VALUE, VALUE);
extern VALUE  Enum_case_eq(VALUE, VALUE);
extern VALUE  Enum_type_initialize(VALUE, VALUE, VALUE);
extern VALUE  Enum_type_each(VALUE);


extern void  *magick_malloc(const size_t);
extern void  *magick_safe_malloc(const size_t, const size_t);
extern void   magick_free(void *);
extern void  *magick_realloc(void *, size_t);
extern void  *magick_safe_realloc(void *, const size_t, const size_t);
extern void   magick_clone_string(char **, const char *);
extern VALUE  rm_enum_new(VALUE, VALUE, VALUE);
extern VALUE  rm_no_freeze(VALUE);
#if !defined(StringValuePtr)
extern char  *rm_string_value_ptr(volatile VALUE *);
#endif
extern char  *rm_string_value_ptr_len(volatile VALUE *, long *);
extern int    rm_strcasecmp(const char *, const char *);
extern int    rm_strncasecmp(const char *, const char *, size_t);
extern void   rm_check_ary_len(VALUE, long);
extern Image *rm_check_destroyed(VALUE);
extern Image *rm_check_frozen_image(VALUE);
extern int    rm_check_num2dbl(VALUE);
extern double rm_fuzz_to_dbl(VALUE);
extern Quantum rm_app2quantum(VALUE);
extern double rm_percentage(VALUE);
extern double rm_str_to_pct(VALUE);
extern VALUE  rm_define_enum_type(char *);
extern void   rm_write_temp_image(Image *, char *);
extern void   rm_delete_temp_image(char *);
extern void   rm_not_implemented(void);
extern void   rm_attr_write(VALUE, VALUE);
extern void   rm_get_geometry(VALUE, long *, long *, unsigned long *, unsigned long *, int *);
extern const char *rm_get_property(const Image *, const char *);
extern MagickBooleanType rm_set_property(Image *, const char *, const char *);
extern void   rm_split(Image *);
extern void   rm_magick_error(const char *, const char *);

typedef enum
{
    RetainOnError = 0,
    DestroyOnError = 1
} ErrorRetention;

extern void   rm_check_image_exception(Image *, ErrorRetention);
extern void   rm_check_exception(ExceptionInfo *, Image *, ErrorRetention);
extern void   rm_ensure_result(Image *);
extern Image *rm_clone_image(Image *);
extern MagickBooleanType rm_progress_monitor(const char *, const MagickOffsetType, const MagickSizeType, void *);
extern VALUE  rm_exif_by_entry(Image *);
extern VALUE  rm_exif_by_number(Image *);

#endif

