# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: okraus <okraus@student.42prague.com>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/03/04 15:40:17 by okraus            #+#    #+#              #
#    Updated: 2023/06/15 18:48:59 by okraus           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ifndef ECHO
HIT_TOTAL	!=	${MAKE} ${MAKECMDGOALS} --dry-run ECHO="HIT_MARK" | grep -c "HIT_MARK"
HIT_COUNT1	=	$(eval HIT_N != expr ${HIT_N} + 1)${HIT_N}
HIT_COUNT2	=	$(eval HIT_M != expr ${HIT_M} + 1)${HIT_M}
HIT_COUNT3	=	$(eval HIT_O != expr ${HIT_O} + $(BAR_LENGTH))${HIT_O}
PERC		=	$(shell expr $(HIT_COUNT3) / $(HIT_TOTAL) | bc)
ECHO		=	echo "[`expr ${HIT_COUNT1} '*' 100 / ${HIT_TOTAL}`%]"
endif

NAME		=	pipex
LIBFT_F		=	libft/
LIBFT		=	libft.a
CC 			=	cc
CFLAGS		=	-Wall -Wextra -Werror -O3
OBJ_DIR		=	objects/
SLEEP		=	#sleep 0.5

# SOURCES

SRC			=	$(addprefix $(SRC_DIR), $(addsuffix .c, $(SRC_S)))

# Source directories

SRC_DIR		=	src/

# Pipex functions

SRC_S	=		ft_getinfo \
				ft_paths \
				ft_pipes \
				ft_pipex \
				ft_utils

# Formating

NRM_FORMAT	=	\033[0m

GREEN		=	\033[1;32m
YELLOW		=	\033[1;93m
RED			=	\033[1;31m
REVERSE		=	\033[7m
RETURN		=	\033[1F\r\033[2K

# Printing

BAR_LENGTH	:=	50
PRINT1		=	printf "[$(HIT_COUNT2)/$(HIT_TOTAL)]" ;
PRINT2		=	for num in `seq 1 $(BAR_LENGTH)` ; do \
					if [ $$num -le $(PERC) ] ; then \
						printf "$(REVERSE) $(NRM_FORMAT)" ; \
					else \
						printf " " ; \
        			fi \
    			done

# Objects

OBJ			=	$(addprefix $(OBJ_DIR), $(addsuffix .o, $(SRC_S)))

# RULES

all:			announce $(LIBFT) $(NAME)
				@$(PRINT2)
				@$(PRINT1)
				@$(ECHO)
				@echo "$(GREEN)Amazing <<$(REVERSE)pipex$(NRM_FORMAT)$(GREEN)>> compiled!$(NRM_FORMAT)"
				

bonus:			all

# MESSAGES 

announce: 
				@echo "$(RED)You should not see this (unless the program already exists)\n$(NRM_FORMAT)"


# COMPILATION

$(OBJ_DIR)%.o:	$(SRC_DIR)%.c
				@mkdir -p $(OBJ_DIR)
				@$(SLEEP)
				@echo "$(RETURN)$(RETURN)$(YELLOW)Compiling PIPEX: $< $(NRM_FORMAT)"
				@$(PRINT2)
				@$(PRINT1)
				@$(CC) $(CFLAGS) -c $< -o $@
				@$(ECHO)

$(NAME): 		$(OBJ)
				@echo "$(RETURN)$(RETURN)$(GREEN)Libft compilation complete!$(NRM_FORMAT)"
				@$(CC) $(CFLAGS) $(SRC) libft.a -o $(NAME)
				@$(PRINT2)
				@$(PRINT1)
				@$(ECHO)
				@echo "$(RETURN)$(RETURN)$(GREEN)Pipex compiled!$(NRM_FORMAT)"

$(LIBFT):
				@echo "$(RETURN)$(RETURN)$(YELLOW)Compiling LIBFT: $< $(NRM_FORMAT)"
				@make -s -C $(LIBFT_F)
				@cp libft/libft.a .
				@echo "$(YELLOW)Compiling PIPEX: $< $(NRM_FORMAT)"
				@$(PRINT2)
				@$(PRINT1)
				@$(ECHO)

# clean library

clean:
				@rm -rf $(OBJ_DIR)
				@make fclean -s -C $(LIBFT_F)
				@echo "$(RED)Objects removed!$(NRM_FORMAT)"
				@$(PRINT2)
				@$(PRINT1)
				@$(ECHO)

# Remove the program after running clean

fclean:			clean
				@rm $(LIBFT)
				@rm $(NAME)
				@echo "$(RETURN)$(RED)Library and program deleted!$(NRM_FORMAT)"
				@$(PRINT2)
				@$(PRINT1)
				@$(ECHO)

# Remove stuff and make it all again

re: 			fclean all
				@$(PRINT2)
				@$(PRINT1)
				@$(ECHO)

# Phony stuff for rules

.PHONY: all announce clean fclean re bonus
