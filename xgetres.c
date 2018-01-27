#include <stdio.h>
#include <getopt.h>
#include <X11/Xresource.h>

static int print_xresource(const char *resource)
{
    int ret;

    XrmInitialize();

    Display *display = XOpenDisplay(NULL);
    if (NULL == display) {
        fprintf(stderr, "Can't open display\n");
        ret = -1;
        goto cleanup;
    }

    char *resource_manager = XResourceManagerString(display);
    if (NULL == resource_manager) {
        fprintf(stderr, "Can't obtain RESOURCE_MANAGER\n");
        ret = -1;
        goto cleanup;
    }

    XrmDatabase db = XrmGetStringDatabase(resource_manager);
    if (NULL == db) {
        fprintf(stderr, "Can't open resource database\n");
        ret = -1;
        goto cleanup;
    }

    XrmValue value;
    char *type;
    if (XrmGetResource(db, resource, resource, &type, &value)) {
        printf("%s\n", value.addr);
        ret = 0;
    } else {
        // Resource not found
        ret = 1;
    }

cleanup:
    if (NULL != display) {
        XCloseDisplay(display);
    }
    return ret;
}

#define USAGE "Usage: %s [OPTION] RESOURCE\n"

int main(int argc, char * const argv[])
{
    struct option options[] = {
        {"help",    no_argument, NULL, 'h'},
        {"version", no_argument, NULL, 'v'},
        {0, 0, 0, 0}
    };
    switch(getopt_long(argc, argv, "hv", options, NULL)) {
    case 'h':
        printf(USAGE
               "Get the value of the X resource named RESOURCE\n"
               "\n"
               "Options:\n"
               "  -h, --help     Prints this help message\n"
               "  -v, --version  Prints the version\n",
               argv[0]);
        return 0;
    case 'v':
        printf("xgetres " VERSION "\n");
        return 0;
    case -1:
        if (2 == argc) {
            return print_xresource(argv[1]);
        }
    default:
        fprintf(stderr, USAGE
                "Try '%s -h' for more information\n",
                argv[0], argv[0]);
        return -1;
    }
}
