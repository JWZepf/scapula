
def get_register_func(reg):
    return "aarch64_{rname}_get".format(
        rname=reg.name.lower()
    )


def get_register_field_func(reg, field):
    return "aarch64_{rname}_{fname}_{getter}".format(
        rname=reg.name.lower(),
        fname=field.name.lower(),
        getter="is_enabled" if field.lsb == field.msb else "get"
    )


def print_msg(msg):
    return "BOOTLOADER_PRINT(\"{msg}\");".format(msg=str(msg))


def print_error(msg):
    return "BOOTLOADER_ERROR(\"" + str(msg) + "\");"


def read_all_fields(outfile, reg, el=None):
    reg_size = "uint64_t" if reg.size == 64 else "uint32_t"
    outfile.write(reg_size + " val = 0;\n\n")

    for fs_idx, fs in enumerate(reg.fieldsets):
        for f_idx, f in enumerate(fs.fields):

            rname = reg.name.lower()
            fname = f.name.lower()
            f_getter_name = get_register_field_func(reg, f)

            if el:
                outfile.write("switch_to_el({el});\n".format(el=int(el)))

            outfile.write("val = " + f_getter_name + "();\n")
            outfile.write("BOOTLOADER_PRINT(\"{r}.{f}: %x\", val);\n".format(
                r=rname,
                f=fname
            ))

            if f_idx != (len(fs.fields) - 1):
                outfile.write("\n")

        if fs_idx != (len(reg.fieldsets) - 1):
            outfile.write("\n")