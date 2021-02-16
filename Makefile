VERSION = 1.0
RELEASE = 1
NAME    = node-exporter-textfile-collector-scripts
SPECFILE = ~/rpmbuild/SPECS/$(NAME).spec
SOURCED    = $(NAME)-$(VERSION)
SOURCEFILE = $(SOURCED).tar
SOURCEPATH = ~/rpmbuild/SOURCES/$(SOURCEFILE)
SCRIPTS = apt.sh              inotify-instances   md_info_detail.sh   ntpd_metrics.py     \
smartmon.py         btrfs_stats.py      ipmitool            md_info.sh          nvme_metrics.sh     \
smartmon.sh         mellanox_hca_temp   pacman.sh           storcli.py          deleted_libraries.py\
lvm-prom-collector  multipathd_info     tw_cli.py           directory-size.sh   yum.sh              

default: $(SPECFILE) $(SOURCEPATH)
	@rpmbuild -ba $(SPECFILE)

$(SPECFILE): Makefile
	@echo "Name:       $(NAME)" > $(SPECFILE)
	@echo "Version:    $(VERSION)" >> $(SPECFILE)
	@echo "Release:    $(RELEASE)" >> $(SPECFILE)
	@echo "Summary:    These scripts are examples to be used with the Node Exporter Textfile Collector." >> $(SPECFILE)
	@echo "License:    GPL" >> $(SPECFILE)
	@echo "Source:    $(SOURCEFILE)" >> $(SPECFILE)
	@echo "Requires:    nvme-cli" >> $(SPECFILE)
	@echo "Requires:    python3" >> $(SPECFILE)
	@echo "%define debug_package %{nil}" >> $(SPECFILE)
	@echo "" >> $(SPECFILE)
	@echo "%description" >> $(SPECFILE)
	@echo "To use these scripts, we recommend using a sponge to atomically write the output." >> $(SPECFILE)
	@echo "" >> $(SPECFILE)
	@echo "<collector_script> | sponge <output_file>" >> $(SPECFILE)
	@echo "" >> $(SPECFILE)
	@echo "Sponge comes from moreutils" >> $(SPECFILE)
	@echo "" >> $(SPECFILE)
	@echo "brew install moreutils" >> $(SPECFILE)
	@echo "apt install moreutils" >> $(SPECFILE)
	@echo "pkg install moreutils" >> $(SPECFILE)
	@echo "" >> $(SPECFILE)
	@echo "For more information see: https://github.com/prometheus/node_exporter#textfile-collector" >> $(SPECFILE)
	@echo "" >> $(SPECFILE)
	@echo "%prep" >> $(SPECFILE)
	@echo "%setup -q" >> $(SPECFILE)
	@echo "" >> $(SPECFILE)
	@echo "%build" >> $(SPECFILE)
	@echo "" >> $(SPECFILE)
	@echo "%install" >> $(SPECFILE)
	@echo "" >> $(SPECFILE)
	@echo "mkdir -p %{buildroot}/usr/local/bin/" >> $(SPECFILE)
	@for script in $(SCRIPTS) ; do \
	       	echo "install -m 755 $$script %{buildroot}/usr/local/bin/$$script" >> $(SPECFILE) ; \
	done
	@echo "" >> $(SPECFILE)
	@echo "%files" >> $(SPECFILE)
	@for script in $(SCRIPTS) ; do \
	       	echo "/usr/local/bin/$$script" >> $(SPECFILE) ; \
	done
	@echo "" >> $(SPECFILE)
	@echo "%changelog" >> $(SPECFILE)
	@echo "" >> $(SPECFILE)
	@echo "# let's skip this for now" >> $(SPECFILE)

$(SOURCEPATH) : $(SOURCES)
	@rm -rf $(SOURCED)
	@mkdir  $(SOURCED)
	@for script in $(SCRIPTS) ; do \
	       	cp $$script $(SOURCED) ; \
	done
	@tar cf $(SOURCEPATH) $(SOURCED)
	@rm -rf $(SOURCED)
