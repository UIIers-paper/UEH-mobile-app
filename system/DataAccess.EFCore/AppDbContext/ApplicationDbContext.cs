
using Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace DataAccess.EFCore.AppDbContext
{
    public partial class ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : DbContext(options)
    {
        #region DbSet
        public virtual DbSet<CaThi> CaThis { get; set; }

        public virtual DbSet<DeThi> DeThis { get; set; }

        public virtual DbSet<Dept> Depts { get; set; }

        public virtual DbSet<DotThi> DotThis { get; set; }

        public virtual DbSet<DotThiCanBoCoiThi> DotThiCanBoCoiThis { get; set; }

        public virtual DbSet<DotThiDeThi> DotThiDeThis { get; set; }

        public virtual DbSet<LuotThi> LuotThis { get; set; }

        public virtual DbSet<LuotThiStep> LuotThiSteps { get; set; }

        public virtual DbSet<NhomDe> NhomDes { get; set; }

        public virtual DbSet<Question> Questions { get; set; }

        public virtual DbSet<QuestionAnswer> QuestionAnswers { get; set; }

        public virtual DbSet<QuestionCategory> QuestionCategories { get; set; }

        public virtual DbSet<QuestionType> QuestionTypes { get; set; }

        public virtual DbSet<QuestionUsage> QuestionUsages { get; set; }

        public virtual DbSet<Subject> Subjects { get; set; }

        public virtual DbSet<SubjectQuestionCategory> SubjectQuestionCategories { get; set; }

        public virtual DbSet<ThongTinSinhVien> ThongTinSinhViens { get; set; }

        public virtual DbSet<ThongTinSinhVienTemp> ThongTinSinhVienTemps { get; set; }

        public virtual DbSet<User> Users { get; set; }
        #endregion

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<CaThi>(entity =>
            {
                entity.ToTable("CaThi");

                entity.Property(e => e.MkgiamThi).HasColumnName("MKGiamThi");
                entity.Property(e => e.ThucTeBd).HasColumnName("ThucTeBD");
                entity.Property(e => e.ThucTeKt).HasColumnName("ThucTeKT");

                entity.HasOne(d => d.NhomDe).WithMany(p => p.CaThis)
                    .HasForeignKey(d => d.NhomDeId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CaThi_NhomDe");

                entity.HasOne(d => d.Subject).WithMany(p => p.CaThis)
                    .HasForeignKey(d => d.SubjectId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CaThi_Subject");
            });

            modelBuilder.Entity<DeThi>(entity =>
            {
                entity.ToTable("DeThi");

                entity.Property(e => e.DecimalPoints).HasDefaultValue((short)2);
                entity.Property(e => e.MaxGrade).HasDefaultValue(10f);
                entity.Property(e => e.Name).HasMaxLength(255);

                entity.HasOne(d => d.NhomDe).WithMany(p => p.DeThis)
                    .HasForeignKey(d => d.NhomDeId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_DeThi_NhomDe");
            });

            modelBuilder.Entity<Dept>(entity =>
            {
                entity.ToTable("Dept");

                entity.Property(e => e.Code).HasMaxLength(50);
                entity.Property(e => e.Name).HasMaxLength(255);
            });

            modelBuilder.Entity<DotThi>(entity =>
            {
                entity.ToTable("DotThi");
            });

            modelBuilder.Entity<DotThiCanBoCoiThi>(entity =>
            {
                entity.ToTable("DotThiCanBoCoiThi");
            });

            modelBuilder.Entity<DotThiDeThi>(entity =>
            {
                entity.ToTable("DotThiDeThi");
            });

            modelBuilder.Entity<LuotThi>(entity =>
            {
                entity.ToTable("LuotThi");

                entity.Property(e => e.LaTsngoai).HasColumnName("LaTSNgoai");
                entity.Property(e => e.Mssv).HasMaxLength(20);
                entity.Property(e => e.SumGrades).HasColumnType("decimal(18, 2)");

                entity.HasOne(d => d.CaThi).WithMany(p => p.LuotThis)
                    .HasForeignKey(d => d.CaThiId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_LuotThi_CaThi");

                entity.HasOne(d => d.DeThi).WithMany(p => p.LuotThis)
                    .HasForeignKey(d => d.DeThiId)
                    .HasConstraintName("FK_LuotThi_DeThi");
            });

            modelBuilder.Entity<LuotThiStep>(entity =>
            {
                entity.ToTable("LuotThiStep");
            });

            modelBuilder.Entity<NhomDe>(entity =>
            {
                entity.ToTable("NhomDe");

                entity.Property(e => e.ChoXemDiem).HasDefaultValue(1);
                entity.Property(e => e.GhiChuGv).HasColumnName("GhiChuGV");
                entity.Property(e => e.Slde).HasColumnName("SLDe");
                entity.Property(e => e.TongSlcauHoi).HasColumnName("TongSLCauHoi");

                entity.HasOne(d => d.Subject).WithMany(p => p.NhomDes)
                    .HasForeignKey(d => d.SubjectId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_NhomDe_Subject");
            });

            modelBuilder.Entity<Question>(entity =>
            {
                entity.ToTable("Question");

                entity.Property(e => e.Qtype)
                    .HasMaxLength(20)
                    .HasColumnName("QType");

                entity.HasOne(d => d.QtypeNavigation).WithMany(p => p.Questions)
                    .HasForeignKey(d => d.Qtype)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Question_QuestionType");
            });

            modelBuilder.Entity<QuestionAnswer>(entity =>
            {
                entity.ToTable("QuestionAnswer");

                entity.Property(e => e.Fraction).HasDefaultValue((short)100);

                entity.HasOne(d => d.Question).WithMany(p => p.QuestionAnswers)
                    .HasForeignKey(d => d.QuestionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_QuestionAnswer_Question");
            });

            modelBuilder.Entity<QuestionCategory>(entity =>
            {
                entity.ToTable("QuestionCategory");

                entity.Property(e => e.FileName).HasMaxLength(255);
                entity.Property(e => e.FilePath).HasMaxLength(255);
                entity.Property(e => e.Name).HasMaxLength(255);

                entity.HasOne(d => d.Subject).WithMany(p => p.QuestionCategories)
                    .HasForeignKey(d => d.SubjectId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_QuestionCategory_Subject");
            });

            modelBuilder.Entity<QuestionType>(entity =>
            {
                entity.HasKey(e => e.Code);

                entity.ToTable("QuestionType");

                entity.Property(e => e.Code).HasMaxLength(20);
                entity.Property(e => e.Desc).HasMaxLength(500);
            });

            modelBuilder.Entity<QuestionUsage>(entity =>
            {
                entity.ToTable("QuestionUsage");

                entity.Property(e => e.MaxFraction).HasDefaultValue((short)100);
                entity.Property(e => e.MaxMark).HasDefaultValue(1f);

                entity.HasOne(d => d.Question).WithMany(p => p.QuestionUsages)
                    .HasForeignKey(d => d.QuestionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_QuestionUsage_Question");
            });

            modelBuilder.Entity<Subject>(entity =>
            {
                entity.ToTable("Subject");

                entity.Property(e => e.Name).HasMaxLength(500);

                entity.HasOne(d => d.CreatedByNavigation).WithMany(p => p.SubjectCreatedByNavigations)
                    .HasForeignKey(d => d.CreatedBy)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Subject_User1");

                entity.HasOne(d => d.User).WithMany(p => p.SubjectUsers)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Subject_User");
            });

            modelBuilder.Entity<SubjectQuestionCategory>(entity =>
            {
                entity.ToTable("SubjectQuestionCategory");

                entity.HasOne(d => d.QuestionCategory).WithMany(p => p.SubjectQuestionCategories)
                    .HasForeignKey(d => d.QuestionCategoryId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_SubjectQuestionCategory_QuestionCategory");

                entity.HasOne(d => d.Subject).WithMany(p => p.SubjectQuestionCategories)
                    .HasForeignKey(d => d.SubjectId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_SubjectQuestionCategory_Subject");
            });

            modelBuilder.Entity<ThongTinSinhVien>(entity =>
            {
                entity.HasKey(e => e.StudentId);

                entity.ToTable("ThongTinSinhVien");

                entity.Property(e => e.StudentId)
                    .HasMaxLength(20)
                    .HasColumnName("StudentID");
                entity.Property(e => e.BirthDay).HasMaxLength(20);
                entity.Property(e => e.ClassStudentId)
                    .HasMaxLength(20)
                    .HasColumnName("ClassStudentID");
                entity.Property(e => e.FirstName).HasMaxLength(255);
                entity.Property(e => e.LastName).HasMaxLength(100);
                entity.Property(e => e.MiddleName).HasMaxLength(100);
            });

            modelBuilder.Entity<ThongTinSinhVienTemp>(entity =>
            {
                entity.HasKey(e => e.StudentId);

                entity.ToTable("ThongTinSinhVienTemp");

                entity.Property(e => e.StudentId)
                    .HasMaxLength(20)
                    .HasColumnName("StudentID");
                entity.Property(e => e.BirthDay).HasMaxLength(20);
                entity.Property(e => e.ClassStudentId)
                    .HasMaxLength(20)
                    .HasColumnName("ClassStudentID");
                entity.Property(e => e.FirstName).HasMaxLength(255);
                entity.Property(e => e.LastName).HasMaxLength(100);
                entity.Property(e => e.MiddleName).HasMaxLength(100);
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.ToTable("User");

                entity.Property(e => e.Email).HasMaxLength(100);
                entity.Property(e => e.Fullname).HasMaxLength(255);
                entity.Property(e => e.Password).HasMaxLength(500);
                entity.Property(e => e.Phone1).HasMaxLength(20);
                entity.Property(e => e.Phone2).HasMaxLength(20);
                entity.Property(e => e.Username).HasMaxLength(100);

                entity.HasOne(d => d.Department).WithMany(p => p.Users)
                    .HasForeignKey(d => d.DepartmentId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_User_Dept");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
