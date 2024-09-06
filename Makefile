default:
	stow . --no-folding --target=${HOME}
	@if [[ ! -e ${HOME}/.zshrc ]]; then \
		ln -s ${HOME}/.config/zsh/.zshrc ${HOME}/.zshrc; \
	fi
	@if [[ ! -e ${HOME}/.bashrc ]]; then \
		ln -s ${HOME}/.config/bash/.bashrc ${HOME}/.bashrc; \
	fi

clean:
	stow -D .
	@if [[ -L ${HOME}/.zshrc ]]; then \
		rm ${HOME}/.zshrc; \
	fi
	@if [[ -L ${HOME}/.bashrc ]]; then \
		rm ${HOME}/.bashrc; \
	fi
