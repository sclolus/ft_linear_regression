(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   linear_regression.mli                              :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: sclolus <marvin@42.fr>                     +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2018/10/17 06:24:30 by sclolus           #+#    #+#             *)
(*   Updated: 2018/10/17 07:00:15 by sclolus          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

val train_on_dataset: Dataset.dataset -> float -> (float * float)
val guess_target: float -> float -> float -> float
